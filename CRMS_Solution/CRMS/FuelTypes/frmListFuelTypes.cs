using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.FuelTypes
{
    public partial class frmListFuelTypes : Form
    {
        private DataTable _dtAllFuelTypes = null;
        private DataView _FuelTypesView;

        public frmListFuelTypes()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllFuelTypes = clsFuelType.GetAllFuelTypes();

            if (_dtAllFuelTypes == null)
                return;

            _FuelTypesView = _dtAllFuelTypes.DefaultView;
            dgvFuelTypes.DataSource = _FuelTypesView;
            lblRecordsCount.Text = _FuelTypesView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_FuelTypesView == null)
                return;

            if(string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _FuelTypesView.RowFilter = "";
                lblRecordsCount.Text = _FuelTypesView.Count.ToString();
                return;
            }

            if (ColumnName == FuelTypeID.Name)
                _FuelTypesView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _FuelTypesView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());
            
            lblRecordsCount.Text = _FuelTypesView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Fuel Type ID": return FuelTypeID.Name;
                case "Fuel Type":    return FuelType.Name;
            }
            return "";
        }

        private void frmListFuelTypes_Load(object sender, EventArgs e)
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

            if (_FuelTypesView == null)
                return;

            _FuelTypesView.RowFilter = "";
            lblRecordsCount.Text = _FuelTypesView.Count.ToString();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Fuel Type ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnAddFuelType_Click(object sender, EventArgs e)
        {
            frmAddUpdateFuelType AddFuelType = new frmAddUpdateFuelType();
            AddFuelType.OnAddUpdateFuelType += AddFuelType_OnAddUpdateFuelType;
            AddFuelType.ShowDialog();
        }

        private void AddFuelType_OnAddUpdateFuelType(int FuelTypeID) => _LoadData();

        private void ShowFuelTypeInfoItem_Click(object sender, EventArgs e)
        {
            frmShowFuelTypeInfo showFuelTypeInfo = new frmShowFuelTypeInfo((int)dgvFuelTypes.CurrentRow.Cells["FuelTypeID"].Value);
            showFuelTypeInfo.OnFuelTypeChanged += AddFuelType_OnAddUpdateFuelType;
            showFuelTypeInfo.ShowDialog();
        }

        private void EditFuelTypeItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateFuelType EditFuelType = new frmAddUpdateFuelType((int)dgvFuelTypes.CurrentRow.Cells["FuelTypeID"].Value);
            EditFuelType.OnAddUpdateFuelType += AddFuelType_OnAddUpdateFuelType;
            EditFuelType.ShowDialog();
        }

        private void DeleteFuelTypeItem_Click(object sender, EventArgs e)
        {
            if (dgvFuelTypes.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Fuel Type?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsFuelType.DeleteFuelType((int)dgvFuelTypes.CurrentRow.Cells["FuelTypeID"].Value))
                MessageBox.Show("Deleted Data Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("Doesn't Delete Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}