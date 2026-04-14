using CRMS.RentalBooking;
using CRMS.Vehicle;
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

namespace CRMS.VehicleReturn
{
    public partial class frmListVehiclesReturn : Form
    {
        private DataTable _dtVehiclesReturn = null;
        private DataView _VehiclesReturnView;

        public frmListVehiclesReturn()
        {
            InitializeComponent();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_dtVehiclesReturn == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
                _VehiclesReturnView.RowFilter = "";

            else if (ColumnName == ReturnID.Name || ColumnName == VehicleID.Name || ColumnName == BookingID.Name)
                _VehiclesReturnView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _VehiclesReturnView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _VehiclesReturnView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Return ID": return ReturnID.Name;
                case "Booking ID":return BookingID.Name;
                case "Vehicle ID": return VehicleID.Name;
                case "Make Name": return MakeName.Name;
                case "Model Name": return ModelName.Name;
                case "Fuel Type":return FuelType.Name;
                case "Category Name": return CategoryName.Name;
            }
            return "";
        }

        private void _LoadData()
        {
            _dtVehiclesReturn = clsVehicleReturn.GetAllVehiclesReturn();

            if (_dtVehiclesReturn == null)
                return;

            _VehiclesReturnView = _dtVehiclesReturn.DefaultView;
            dgvVehiclesReturn.DataSource = _VehiclesReturnView;
            lblRecordsCount.Text = _VehiclesReturnView.Count.ToString();
        }

        private void frmListVehiclesReturn_Load(object sender, EventArgs e)
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

            if (_dtVehiclesReturn == null)
                return;

            txtFilterValue.Clear();
            _VehiclesReturnView.RowFilter = "";
            lblRecordsCount.Text = _VehiclesReturnView.Count.ToString();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Return ID" || cbFilterBy.Text == "Vehicle ID" || cbFilterBy.Text == "Booking ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void ShowVehicleReturnInfoItem_Click(object sender, EventArgs e)
        {
            if (dgvVehiclesReturn.CurrentCell == null)
                return;

            int BookingID = (int)dgvVehiclesReturn.CurrentRow.Cells["BookingID"].Value;
            int ReturnID = (int)dgvVehiclesReturn.CurrentRow.Cells["ReturnID"].Value;

            frmShowVehicleReturnInfo showVehicleReturnInfo = new frmShowVehicleReturnInfo(BookingID, ReturnID);
            showVehicleReturnInfo.ShowDialog();
        }

        private void ShowVehicleInfoItem_Click(object sender, EventArgs e)
        {
            frmShowVehicleInfo showVehicleInfo = new frmShowVehicleInfo((int)dgvVehiclesReturn.CurrentRow.Cells["VehicleID"].Value);
            showVehicleInfo.ShowDialog();
        }

        private void ShowBookingInfoItem_Click(object sender, EventArgs e)
        {
            frmShowRentalBookingInfo showRentalBookingInfo = new frmShowRentalBookingInfo((int)dgvVehiclesReturn.CurrentRow.Cells["BookingID"].Value);
            showRentalBookingInfo.ShowDialog();
        }

        private void DeleteVehicleReturnItem_Click(object sender, EventArgs e)
        {
            if (dgvVehiclesReturn.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Vehicle Return?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsVehicleReturn.DeleteVehicleReturn((int)dgvVehiclesReturn.CurrentRow.Cells["ReturnID"].Value))
                MessageBox.Show("Deleted Vehicle Return Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Doesn't Deleted Vehicle Return", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}