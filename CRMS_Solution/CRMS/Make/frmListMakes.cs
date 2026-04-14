using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.Make
{
    public partial class frmListMakes : Form
    {
        private DataTable _dtAllMakes = null;
        private DataView _MakesView;

        public frmListMakes()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllMakes = clsMake.GetAllMakes();

            if (_dtAllMakes == null)
                return;

            _MakesView = _dtAllMakes.DefaultView;
            dgvMakes.DataSource = _MakesView;
            lblRecordsCount.Text = _MakesView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_MakesView == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
            {                
                _MakesView.RowFilter = "";
                lblRecordsCount.Text = _MakesView.Count.ToString();
                return;
            }

            if (ColumnName == MakeID.Name)
                _MakesView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _MakesView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _MakesView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch(cbFilterBy.Text)
            {
                case "Make ID": return MakeID.Name;
                case "Make Name": return MakeName.Name;
            }

            return "";
        }

        private void frmListMakes_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_MakesView == null)
                return;

            if (cbFilterBy.Text == "None")
                txtFilterValue.Visible = false;

            else
                txtFilterValue.Visible = true;

            txtFilterValue.Clear();
            _MakesView.RowFilter = "";
            lblRecordsCount.Text = _MakesView.Count.ToString();
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Make ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void btnAddNewMake_Click(object sender, EventArgs e)
        {
            frmAddUpdateMake AddMake = new frmAddUpdateMake();
            AddMake.OnMakeChanged += AddUpdateMake_OnMakeChanged;
            AddMake.ShowDialog();
        }

        private void AddUpdateMake_OnMakeChanged(object sender, frmAddUpdateMake.MakeEventArgs e)
        {
            _LoadData();
        }

        private void ShowMakeInfoItem_Click(object sender, EventArgs e)
        {
            frmShowMakeInfo showMakeInfo = new frmShowMakeInfo((int)dgvMakes.CurrentRow.Cells["MakeID"].Value);
            showMakeInfo.OnMakeChanged += ShowMakeInfo_OnMakeChanged; ;
            showMakeInfo.ShowDialog();
        }

        private void ShowMakeInfo_OnMakeChanged(int MakeID)
        {
            _LoadData();
        }

        private void EditMakeItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateMake EditMake = new frmAddUpdateMake((int)dgvMakes.CurrentRow.Cells["MakeID"].Value);
            EditMake.OnMakeChanged += AddUpdateMake_OnMakeChanged;
            EditMake.ShowDialog();
        }

        private void DeleteMakeItem_Click(object sender, EventArgs e)
        {
            if (dgvMakes.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Make?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsMake.DeleteMake((int)dgvMakes.CurrentRow.Cells["MakeID"].Value))
                MessageBox.Show("Deleted Make Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Doesn't Delete Make", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }      

        private void FindMake_OnMakeSelected(int MakeID)
        {
            MessageBox.Show($"Make ID = {MakeID}", "Found", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void ShowMakeModelsHistoryItem_Click(object sender, EventArgs e)
        {
            frmShowMakeModelsHistory showMakeModelsHistory = new frmShowMakeModelsHistory((int)dgvMakes.CurrentRow.Cells["MakeID"].Value);
            showMakeModelsHistory.ShowDialog();
        }
    }
}