using CRMS.GlobalClasses;
using CRMS.Properties;
using CRMS.Vehicle;
using CRMS_Business;
using System;
using System.IO;
using System.Windows.Forms;

namespace CRMS.RentalBooking.Controls
{
    public partial class ctrlRentalBookingCard : UserControl
    {
        private int _BookingID = -1;
        public int BookingID => _BookingID;

        private clsRentalBooking _RentalBooking = null;
        public clsRentalBooking RentalBookingSelectedInfo => _RentalBooking;

        public event Action<int> OnBookingChanged;
        protected virtual void BookingChanged(int BookingID)
        {
            Action<int> handler = OnBookingChanged;

            if (handler != null)
                handler(BookingID);
        }

        public ctrlRentalBookingCard()
        {
            InitializeComponent();
        }      

        private void _ResetDefaultValues()
        {
            llEditRentalBookingInfo.Enabled = false;
            _BookingID = -1;
            lblBookingID.Text = "[???]";
            lblCustomerID.Text = "[???]";
            lblCustomerName.Text = "[???]";
            lblIntialCheckNotes.Text = "[???]";
            lblPickupLocation.Text = "[???]";
            lblDropOfLocation.Text = "[???]";
            lblIntialRentalDays.Text = "[???]";
            lblRentalPricePerDay.Text = "[???]";
            lblInitialTotalDueAmount.Text = "[???]";
            lblRentalStartDate.Text = "[???]";
            lblRentalEndDate.Text = "[???]";
            lblCreatedBy.Text = "[???]";
        }

        private void _FillRentalBookingInfoInControls()
        {
            llEditRentalBookingInfo.Enabled = true;
            ctrlVehicleCard1.LoadVehicleInfo(_RentalBooking.VehicleID);
            _BookingID = _RentalBooking.BookingID;
            lblBookingID.Text = _RentalBooking.BookingID.ToString();
            lblCustomerID.Text = _RentalBooking.CustomerID.ToString();
            lblCustomerName.Text = _RentalBooking.CustomerInfo.CustomerName;
            lblIntialCheckNotes.Text = _RentalBooking.InitialCheckNotes;
            lblPickupLocation.Text = _RentalBooking.PickupLocation;
            lblDropOfLocation.Text = _RentalBooking.DropOfLocation;
            lblIntialRentalDays.Text = _RentalBooking.InitialRentalDays.ToString();
            lblRentalPricePerDay.Text = ((int)_RentalBooking.RentalPricePerDay).ToString();
            lblInitialTotalDueAmount.Text = ((int)_RentalBooking.InitialTotalDueAmount).ToString();
            lblRentalStartDate.Text = clsFormat.DateToString(_RentalBooking.RentalStartDate);
            lblRentalEndDate.Text = clsFormat.DateToString(_RentalBooking.RentalEndDate);
            lblCreatedBy.Text = _RentalBooking.CreatedByUserID.ToString();
            BookingChanged(_RentalBooking.BookingID);
        }

        public void LoadRentalBookingInfoByID(int BookingID)
        {
            _RentalBooking = clsRentalBooking.Find(BookingID);

            if(_RentalBooking == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Booking With ID = {BookingID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillRentalBookingInfoInControls();
        }

        public void LoadRentalBookingInfoByVehicleID(int VehicleID)
        {
            _RentalBooking = clsRentalBooking.FindByVehicleID(VehicleID);

            if (_RentalBooking == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Vehicle Is Booking", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillRentalBookingInfoInControls();
        }

        private void llEditRentalBookingInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateRentalBooking EditBooking = new frmAddUpdateRentalBooking(Convert.ToInt32(lblBookingID.Text));
            EditBooking.OnRentalBookingSelected += EditBooking_OnRentalBookingSelected;
            EditBooking.ShowDialog();
        }

        private void EditBooking_OnRentalBookingSelected(object sender, frmAddUpdateRentalBooking.RentalBookingSelectedEventArgs e)
        {
            if (e.RentalBooking == null)
                return;

            LoadRentalBookingInfoByID(e.RentalBooking.BookingID);
            BookingChanged(e.RentalBooking.BookingID);
        }
    }
}