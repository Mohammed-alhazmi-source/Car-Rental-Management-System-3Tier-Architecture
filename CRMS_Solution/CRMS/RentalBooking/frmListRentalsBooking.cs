using CRMS.Vehicle;
using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.RentalBooking
{
    public partial class frmListRentalsBooking : Form
    {
        private DataTable _dtAllRentalsBooking = null;
        private DataView _RentalBookingView;

        public frmListRentalsBooking()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllRentalsBooking = clsRentalBooking.GetAllRentalsBooking();

            if (_dtAllRentalsBooking == null)
                return;

            _RentalBookingView = _dtAllRentalsBooking.DefaultView;
            dgvRentalsBooking.DataSource = _RentalBookingView;
            lblRecordsCount.Text = _RentalBookingView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_dtAllRentalsBooking == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
                _RentalBookingView.RowFilter = "";

            else if (ColumnName == BookingID.Name || ColumnName == VehicleID.Name)
                _RentalBookingView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());
            else
                _RentalBookingView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());
            
            lblRecordsCount.Text = _RentalBookingView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Booking ID": return BookingID.Name;
                case "Customer Name": return CustomerName.Name;
                case "Vehicle ID": return VehicleID.Name;
                case "Make Name": return MakeName.Name;
                case "Model Name": return ModelName.Name;
            }

            return "";
        }

        private void frmListRentalsBooking_Load(object sender, EventArgs e)
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

            if (_dtAllRentalsBooking == null)
                return;

            txtFilterValue.Clear();
            _RentalBookingView.RowFilter = "";
            lblRecordsCount.Text = _RentalBookingView.Count.ToString();
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Booking ID" || cbFilterBy.Text == "Vehicle ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void btnAddNewRentalBooking_Click(object sender, EventArgs e)
        {
            frmAddUpdateRentalBooking AddRentalBooking = new frmAddUpdateRentalBooking();
            AddRentalBooking.OnRentalBookingSelected += AddEditRentalBooking_OnRentalBookingSelected;
            AddRentalBooking.ShowDialog();
        }

        private void AddEditRentalBooking_OnRentalBookingSelected(object sender, frmAddUpdateRentalBooking.RentalBookingSelectedEventArgs e)
        {
            _LoadData();
        }

        private void ShowRentalBookingInfoItem_Click(object sender, EventArgs e)
        {
            if (dgvRentalsBooking.CurrentCell == null)
                return;

            frmShowRentalBookingInfo showRentalBookingInfo = new frmShowRentalBookingInfo((int)dgvRentalsBooking.CurrentRow.Cells["BookingID"].Value);
            showRentalBookingInfo.OnRentalBookingChanged += ShowRentalBookingInfo_OnRentalBookingChanged;
            showRentalBookingInfo.ShowDialog();
        }

        private void ShowRentalBookingInfo_OnRentalBookingChanged(int RentalBookingID)
        {
            _LoadData();
        }

        private void EditRentalBookingItem_Click(object sender, EventArgs e)
        {
            if (dgvRentalsBooking.CurrentCell == null)
                return;

            frmAddUpdateRentalBooking EditRentalBooking = new frmAddUpdateRentalBooking((int)dgvRentalsBooking.CurrentRow.Cells["BookingID"].Value);
            EditRentalBooking.OnRentalBookingSelected += AddEditRentalBooking_OnRentalBookingSelected;
            EditRentalBooking.ShowDialog();
        }

        private void DeleteRentalBookingItem_Click(object sender, EventArgs e)
        {
            if (dgvRentalsBooking.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Rental Booking?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsRentalBooking.DeleteBooking((int)dgvRentalsBooking.CurrentRow.Cells["BookingID"].Value))
                MessageBox.Show("Deleted Successfully", "Succussed", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e) => Close();
    }
}