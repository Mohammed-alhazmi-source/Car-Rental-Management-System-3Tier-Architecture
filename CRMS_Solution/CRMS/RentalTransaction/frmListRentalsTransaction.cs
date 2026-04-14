using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.RentalTransaction
{
    public partial class frmListRentalsTransaction : Form
    {
        private DataTable _dtAllRentalsTransaction = null;
        private DataView _RentalsTransactionView;

        public frmListRentalsTransaction()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllRentalsTransaction = clsRentalTransaction.GetAllRentalTransaction();

            _RentalsTransactionView = _dtAllRentalsTransaction?.DefaultView;
            dgvRentalsTransaction.DataSource = _RentalsTransactionView;
            lblRecordsCount.Text = _RentalsTransactionView?.Count.ToString() ?? "[???]";
        }

        private void _FilterBy(string ColumnName)
        {           
            if(string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
                _RentalsTransactionView.RowFilter = "";

            else if(ColumnName == BookingID.Name || ColumnName == TransactionID.Name || ColumnName == ReturnID.Name || ColumnName == VehicleID.Name)
                _RentalsTransactionView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _RentalsTransactionView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _RentalsTransactionView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Transaction ID": return TransactionID.Name;
                case "Return ID": return ReturnID.Name;
                case "Vehicle ID": return VehicleID.Name;
                case "Booking ID": return BookingID.Name;
                case "Customer Name": return CustomerName.Name;
                case "Make Name": return MakeName.Name;
                case "Model Name": return ModelName.Name;
            }

            return "";
        }

        private void frmListRentalsTransaction_Load(object sender, EventArgs e)
        {
            _LoadData();
            
            if (_dtAllRentalsTransaction == null)
                cbFilterBy.Enabled = false;
            
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                txtFilterValue.Visible = false;

            else
                txtFilterValue.Visible = true;

            if (_dtAllRentalsTransaction == null)
                return;

            txtFilterValue.Clear();
            _RentalsTransactionView.RowFilter = "";
            lblRecordsCount.Text = _RentalsTransactionView.Count.ToString();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Transaction ID" || cbFilterBy.Text == "Return ID" || cbFilterBy.Text == "Vehicle ID" || cbFilterBy.Text == "Booking ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void ShowRentalTransactionItem_Click(object sender, EventArgs e)
        {
            frmShowRentalTransactionInfo showRentalTransactionInfo = new frmShowRentalTransactionInfo((int)dgvRentalsTransaction.CurrentRow.Cells["TransactionID"].Value);
            showRentalTransactionInfo.ShowDialog();
        }

        private void DeleteRentalTransactionItem_Click(object sender, EventArgs e)
        {
            if (dgvRentalsTransaction.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Rental Transaction?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsRentalTransaction.DeleteRentalTransaction((int)dgvRentalsTransaction.CurrentRow.Cells["TransactionID"].Value))
                MessageBox.Show("Deleted Successfully", "Succussed", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
