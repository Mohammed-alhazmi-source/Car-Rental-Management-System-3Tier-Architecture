using CRMS.Make.Controls;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;

namespace CRMS.RentalBooking.Controls
{
    public partial class ctrlRentalBooking : UserControl
    {
        private DataTable _dtAllVehicles = null;
        private DataTable _dtAllVehiclesWithFilterColumns = null;

        private int _CustomerID = -1;
        public int CustomerID
        {
            get { return _CustomerID; }
            set
            {
                _CustomerID = value;
            }
        }

        private clsRentalBooking _RentalBooking = null;

        public void txtValueFilterFocus() => ctrlMakeCardWithFilter1.txtValueFilterFocus();

        private void _InitializeColumnsDataGridView()
        {
            dgvVehicles.Columns[0].Width = 150;
            dgvVehicles.Columns[1].Width = 295;
            dgvVehicles.Columns[2].Width = 295;
            dgvVehicles.Columns[3].Width = 120;
            dgvVehicles.Columns[4].Width = 140;
        }

        public void LoadRentalBookingInfo(int BookingID)
        {
            _RentalBooking = clsRentalBooking.Find(BookingID);

            if(_RentalBooking == null)
            {
                MessageBox.Show($"No Booking With ID = {BookingID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            ctrlMakeCardWithFilter1.LoadMakeInfo(_RentalBooking.VehicleInfo.MakeID);
            ctrlMakeCardWithFilter1.FilterEnabled = false;
        }

        public ctrlRentalBooking()
        {
            InitializeComponent();
        }

        private void ctrlMakeCardWithFilter1_OnMakeSelected(object sender, ctrlMakeCardWithFilter.MakeSelectedEventArgs e)
        {
            if(e.Make == null)
            {
                dgvVehicles.DataSource = null;
                ctrlMakeCardWithFilter1.txtValueFilterFocus();
                lblRecordsCount.Text = "???";
                return;
            }

            _dtAllVehicles = clsVehicle.GetAllVehiclesByMakeName(e.Make.MakeName);          

            if (_dtAllVehicles == null)
            {
                ctrlMakeCardWithFilter1.txtValueFilterFocus();
                lblRecordsCount.Text = "???";
                return;
            }

            _dtAllVehiclesWithFilterColumns = _dtAllVehicles.DefaultView.ToTable(true, "VehicleID", "MakeName", "ModelName", "Mileage", "IsAvailableForRent");
            dgvVehicles.DataSource = _dtAllVehiclesWithFilterColumns;
            lblRecordsCount.Text = dgvVehicles.Rows.Count.ToString();

            _InitializeColumnsDataGridView();
        }

        private void SetBookingItem_Click(object sender, EventArgs e)
        {

        }

        private void cmsBooking_Opening(object sender, CancelEventArgs e)
        {
            SetBookingItem.Enabled = (bool)dgvVehicles.CurrentRow.Cells["IsAvailableForRent"].Value;
        }
    }
}