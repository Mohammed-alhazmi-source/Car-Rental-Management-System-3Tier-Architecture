using CRMS.GlobalClasses;
using CRMS_Business;
using System.Windows.Forms;

namespace CRMS.VehicleReturn.Controls
{
    public partial class ctrlVehicleReturnCard : UserControl
    {
        public int BookingID => ctrlRentalBookingCard1.BookingID;
        public clsRentalBooking RentalBookingSelectedInfo => ctrlRentalBookingCard1.RentalBookingSelectedInfo;

        private int _ReturnID = -1;
        public int ReturnID => _ReturnID;

        private clsVehicleReturn _VehicleReturn = null;
        public clsVehicleReturn SelectedVehicleReturnInfo => _VehicleReturn;

        public ctrlVehicleReturnCard()
        {
            InitializeComponent();
        }

        private void _FillVehicleReturnInfoInControls()
        {
            ctrlRentalBookingCard1.LoadRentalBookingInfoByID(BookingID);
            _ReturnID = _VehicleReturn.ReturnID;
            lblReturnID.Text = _ReturnID.ToString();
            lblActualReturnDate.Text = clsFormat.DateToString(_VehicleReturn.ActualReturnDate);
            lblActualRentalDays.Text = _VehicleReturn.ActualRentalDays.ToString();
            lblMileage.Text = _VehicleReturn.Mileage.ToString();
            lblConsumedMileage.Text = _VehicleReturn.ConsumedMileage.ToString();
            lblAdditionalCharges.Text = ((int)_VehicleReturn.AdditionalCharges).ToString();
            lblActualTotalDueAmount.Text = ((int)_VehicleReturn.ActualTotalDueAmount).ToString();
            lblCreatedBy.Text = _VehicleReturn.CreatedByUserID.ToString();
            lblFinalCheckNotes.Text = _VehicleReturn.FinalCheckNotes;
        }

        private void _ResetDefaultValues()
        {
            _ReturnID = -1;
            lblReturnID.Text = "[???]";
            lblActualReturnDate.Text = "[???]";
            lblActualRentalDays.Text = "[???]";
            lblMileage.Text = "[???]";
            lblConsumedMileage.Text = "[???]";
            lblAdditionalCharges.Text = "[???]";
            lblActualTotalDueAmount.Text = "[???]";
            lblCreatedBy.Text = "[???]";
            lblFinalCheckNotes.Text = "[???]";
        }

        public void LoadVehicleReturnInfo(int BookingID, int ReturnID)
        {
            ctrlRentalBookingCard1.LoadRentalBookingInfoByID(BookingID);

            if (ctrlRentalBookingCard1.RentalBookingSelectedInfo == null)
                return;

            _VehicleReturn = clsVehicleReturn.Find(ReturnID);

            if(_VehicleReturn == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Vehicle Return With ID {ReturnID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillVehicleReturnInfoInControls();
        }
    }
}