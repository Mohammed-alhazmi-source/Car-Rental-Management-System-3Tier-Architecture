using CRMS_Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;

namespace CRMS.Vehicle
{
    public partial class frmListVehicles : Form
    {
        private DataTable _dtVehicles = null;
        private DataView _VehiclesView;
        private DataTable _dt = null;
        private List<string> Models = null;

        public frmListVehicles()
        {
            InitializeComponent();         
        }       

        private void _LoadData()
        {
            _dtVehicles = clsVehicle.GetAllVehicles();

            if(_dtVehicles == null)
            {
                lblRecordsCount.Text = "0";
                return;
            }

            _VehiclesView = _dtVehicles.DefaultView;
            dgvVehicles.DataSource = _VehiclesView;
            lblRecordsCount.Text = _VehiclesView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_dtVehicles == null)
                return;

            if(string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _VehiclesView.RowFilter = "";
                lblRecordsCount.Text = _VehiclesView.Count.ToString();
                return;
            }

            if(ColumnName == VehicleID.Name || ColumnName == Year.Name || ColumnName == Mileage.Name)
            {
                _VehiclesView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());
                lblRecordsCount.Text = _VehiclesView.Count.ToString();
                return;
            }

            _VehiclesView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());
            lblRecordsCount.Text = _VehiclesView.Count.ToString();
        }

        private void _DisabledControls(bool VisibleAvailable, bool VisibleText)
        {
            cbFilterByAvailable.Visible = VisibleAvailable;
            txtFilterValue.Visible = VisibleText;
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Vehicle ID": return VehicleID.Name;
                case "Make Name": return MakeName.Name;
                case "Model Name": return ModelName.Name;
                case "Year": return Year.Name;
                case "Mileage": return Mileage.Name;
                case "Fuel Type": return FuelType.Name;
                case "Category Name": return CategoryName.Name;
            }

            return "";
        }

        private void frmListVehicles_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
            cbFilterByAvailable.SelectedIndex = cbFilterByAvailable.FindString("All");
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                _DisabledControls(false, false);

            else if (cbFilterBy.Text == "Is Available")
            {
                cbFilterByAvailable.SelectedIndex = cbFilterByAvailable.FindString("All");
                _DisabledControls(true, false); 
            }

            else
                _DisabledControls(false, true);

            if (_dtVehicles == null)
                return;

            _VehiclesView.RowFilter = "";
            lblRecordsCount.Text = _VehiclesView.Count.ToString();
            txtFilterValue.Clear();
        }

        private void cbFilterByAvailable_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_dtVehicles == null)
                return;

            if (cbFilterByAvailable.Text == "All")
                _VehiclesView.RowFilter = "";

            else
                _VehiclesView.RowFilter = string.Format
                                        (
                                            "[{0}] = {1}", IsAvailableForRent.Name,
                                            cbFilterByAvailable.Text == "Yes" ? true : false
                                        );

            lblRecordsCount.Text = _VehiclesView.Count.ToString();
        }

        private void btnAddVehicle_Click(object sender, EventArgs e)
        {
            frmAddUpdateVehicle AddVehicle = new frmAddUpdateVehicle();
            AddVehicle.OnVehicleChanged += AddEditVehicle_OnVehicleChanged;
            AddVehicle.ShowDialog();
        }

        private void AddEditVehicle_OnVehicleChanged(int VehicleID) => _LoadData();

        private void ShowVehicleInfoItem_Click(object sender, EventArgs e)
        {            
            frmShowVehicleInfo showVehicleInfo = new frmShowVehicleInfo((int)dgvVehicles.CurrentRow.Cells["VehicleID"].Value);
            showVehicleInfo.OnVehicleChanged += AddEditVehicle_OnVehicleChanged;
            showVehicleInfo.ShowDialog();
        }

        private void EditVehicleItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateVehicle EditVehicle = new frmAddUpdateVehicle((int)dgvVehicles.CurrentRow.Cells["VehicleID"].Value);
            EditVehicle.OnVehicleChanged += AddEditVehicle_OnVehicleChanged;
            EditVehicle.ShowDialog();
        }

        private void DeleteVehicleItem_Click(object sender, EventArgs e)
        {
            if (dgvVehicles.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Vehicle?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsVehicle.DeleteVehicle((int)dgvVehicles.CurrentRow.Cells["VehicleID"].Value))
                MessageBox.Show("Deleted Successfully", "Succussed", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Vehicle ID" || cbFilterBy.Text == "Year" || cbFilterBy.Text == "Mileage")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;

            else
                e.Handled = char.IsPunctuation(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e) => _FilterBy(_GetColumnName());

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void BookingItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateRentalBooking rentalBooking = new frmAddUpdateRentalBooking();
            rentalBooking.OnVehicleBooking += RentalBooking_OnVehicleBooking;
            rentalBooking.ShowDialog();
        }

        private void RentalBooking_OnVehicleBooking(int BookingID)
        {
            _LoadData();
        }

        private void FindVehicleItem_Click(object sender, EventArgs e)
        {
            frmFindVehicle findVehicle = new frmFindVehicle();
            findVehicle.ShowDialog();
        }

        private void cmsVehicles_Opening(object sender, CancelEventArgs e)
        {
            BookingItem.Enabled = (bool)dgvVehicles.CurrentRow.Cells["IsAvailableForRent"].Value;
        }
    }
}