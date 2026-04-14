using CRMS_Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRMS.MakeModels
{
    public partial class frmListModels : Form
    {
        private DataTable _dtAllModels = null;
        private DataView _ModelsView;

        public frmListModels()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllModels = clsMakeModel.GetAllMakeModels();

            if (_dtAllModels == null)
                return;

            _ModelsView = _dtAllModels.DefaultView;
            dgvModels.DataSource = _ModelsView;
            lblRecordsCount.Text = _ModelsView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_ModelsView == null)
                return;

            if(string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _ModelsView.RowFilter = "";
                lblRecordsCount.Text = _ModelsView.Count.ToString();
                return;
            }

            if (ColumnName == ModelID.Name || ColumnName == MakeID.Name)
                _ModelsView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _ModelsView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _ModelsView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch(cbFilterBy.Text)
            {
                case "Model ID":   return ModelID.Name;
                case "Make ID":    return MakeID.Name;
                case "Model Name": return ModelName.Name;
                case "Make Name":  return MakeName.Name;
            }
            return "";
        }

        private void frmListModels_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                txtFilterValue.Visible = false;

            else
                txtFilterValue.Visible = true;

            txtFilterValue.Clear();

            if (_ModelsView == null)
                return;

            _ModelsView.RowFilter = "";
            lblRecordsCount.Text = _ModelsView.Count.ToString();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void btnAddModel_Click(object sender, EventArgs e)
        {
            frmAddUpdateModel AddModel = new frmAddUpdateModel();
            AddModel.OnModelChanged += AddUpdateModel_OnModelChanged;
            AddModel.OnMakeChanged += AddUpdateModel_OnModelChanged;
            AddModel.ShowDialog();

            AddModel.OnModelChanged -= AddUpdateModel_OnModelChanged;
            AddModel.OnMakeChanged -= AddUpdateModel_OnModelChanged;
        }

        private void AddUpdateModel_OnModelChanged(int ModelID) => _LoadData();

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void ShowModelInfoItem_Click(object sender, EventArgs e)
        {
            frmShowModelInfo showModelInfo = new frmShowModelInfo((int)dgvModels.CurrentRow.Cells["ModelID"].Value);
            showModelInfo.OnModelChanged += AddUpdateModel_OnModelChanged;
            showModelInfo.ShowDialog();
        }

        private void EditModelItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateModel EditModel = new frmAddUpdateModel((int)dgvModels.CurrentRow.Cells["ModelID"].Value);
            EditModel.OnModelChanged += AddUpdateModel_OnModelChanged;
            EditModel.OnMakeChanged += AddUpdateModel_OnModelChanged;
            EditModel.ShowDialog();
            EditModel.OnModelChanged -= AddUpdateModel_OnModelChanged;
            EditModel.OnMakeChanged -= AddUpdateModel_OnModelChanged;
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Model ID" || cbFilterBy.Text == "Make ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void DeleteModelItem_Click(object sender, EventArgs e)
        {
            if (dgvModels.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Model?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsMakeModel.DeleteModel((int)dgvModels.CurrentRow.Cells["ModelID"].Value))
                MessageBox.Show("Deleted Model Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Doesn't Delete Model", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
