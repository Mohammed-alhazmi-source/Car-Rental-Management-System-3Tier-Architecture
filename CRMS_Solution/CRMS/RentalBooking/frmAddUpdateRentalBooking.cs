using CRMS.GlobalClasses;
using CRMS.Vehicle.Controls;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;
using static CRMS.GlobalClasses.clsEnums;

namespace CRMS.Vehicle
{
    public partial class frmAddUpdateRentalBooking : Form
    {
        private int _CustomerID = -1;

        private enMode _Mode = enMode.Add;

        private clsRentalBooking _RentalBooking = null;
        private clsRentalTransaction _RentalTransaction = null;

        public event Action<int> OnVehicleBooking;
        protected virtual void VehicleBooking(int BookingID)
        {
            Action<int> handler = OnVehicleBooking;
            if (handler != null)
                handler(BookingID);
        }

        private int _BookingID = -1;

        public frmAddUpdateRentalBooking()
        {
            InitializeComponent();
            _Mode = enMode.Add;
        }

        public frmAddUpdateRentalBooking(int BookingID)
        {
            InitializeComponent();
            _BookingID = BookingID;
            _Mode = enMode.Update;
        }

        public class RentalBookingSelectedEventArgs : EventArgs
        {
            public clsRentalBooking RentalBooking { get; set; }

            public RentalBookingSelectedEventArgs(clsRentalBooking RentalBooking)
            {
                this.RentalBooking = RentalBooking;
            }
        }
        public event EventHandler<RentalBookingSelectedEventArgs> OnRentalBookingSelected;
        private void RaiseOnRentalBookingSelected(clsRentalBooking RentalBookingInfo)
        {
            RaiseOnRentalBookingSelected(new RentalBookingSelectedEventArgs(RentalBookingInfo));
        }
        protected virtual void RaiseOnRentalBookingSelected(RentalBookingSelectedEventArgs e)
        {
            OnRentalBookingSelected?.Invoke(this, e);
        }


        private decimal _CalculateInitialTotalDueAmount()
        {
            return ctrlVehicleCardWithFilter1.VehicleSelectedInfo.RentalPricePerDay * nudInitialRentalDays.Value;
        }

        private void _ResetDefaultValues()
        {
            if (_Mode == enMode.Add)
            {
                lblBookingID.Text = "[???]";
                lblTitle.Text = "Add New Booking";
                dtpRentalEndDate.MinDate = DateTime.Now.AddDays(1);
                dtpRentalEndDate.Value = dtpRentalEndDate.MinDate;
                _RentalBooking = new clsRentalBooking();
                _RentalTransaction = new clsRentalTransaction();
            }
            else
                lblTitle.Text = "Update Rental Booking";


            dtpRentalStartDate.Enabled = false;
            //dtpRentalEndDate.MinDate = DateTime.Now.AddDays(1);
            //dtpRentalEndDate.Value = dtpRentalEndDate.MinDate;
            txtDropOfLocation.Text = "";
            txtPickupLocation.Text = "";
            txtInitialCheckNotes.Text = "";
            txtRentalPricePerDay.Text = "";
            nudInitialRentalDays.Value = 1;
            lblInitialTotalDueAmount.Text = "[???]";
        }

        private void _FillRentalBookingInfoInControls()
        {
            // Load Customer Info
            ctrlCustomerCardWithFilter1.LoadCustomerInfo(_RentalBooking.CustomerID);
            ctrlCustomerCardWithFilter1.FilterEnabled = false;

            // Load Rental Booking Info
            lblBookingID.Text = _RentalBooking.BookingID.ToString();

            if (DateTime.Compare(DateTime.Now, dtpRentalEndDate.Value) < 0)
                dtpRentalEndDate.MinDate = DateTime.Now;
            else
                dtpRentalEndDate.MinDate = _RentalBooking.RentalEndDate;

            dtpRentalEndDate.Value = dtpRentalEndDate.MinDate;            

            ctrlVehicleCardWithFilter1.LoadVehicleInfo(_RentalBooking.VehicleInfo.MakeInfo.MakeName, _RentalBooking.VehicleInfo.ModelInfo.ModelName);
            ctrlVehicleCardWithFilter1.FilterEnabled = false;

            txtPickupLocation.Text = _RentalBooking.PickupLocation;
            txtDropOfLocation.Text = _RentalBooking.DropOfLocation;
            dtpRentalEndDate.MinDate = _RentalBooking.RentalEndDate;
            dtpRentalEndDate.Value = dtpRentalEndDate.MinDate;
            nudInitialRentalDays.Value = _RentalBooking.InitialRentalDays;
            txtRentalPricePerDay.Text = ((int)_RentalBooking.RentalPricePerDay).ToString();
            lblInitialTotalDueAmount.Text = ((int)_RentalBooking.InitialTotalDueAmount).ToString();
            txtInitialCheckNotes.Text = _RentalBooking.InitialCheckNotes;
            txtPaymentDetails.Text = clsRentalTransaction.GetPaymentDetailsByBookingID(_RentalBooking.BookingID);
        }

        private void _LoadRentalBookingInfo()
        {
            _RentalBooking = clsRentalBooking.Find(_BookingID);

            if(_RentalBooking == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Booking With ID {_BookingID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            _FillRentalBookingInfoInControls();
        }

        public override bool ValidateChildren()
        {
            bool Valid = true;

            if(string.IsNullOrEmpty(txtDropOfLocation.Text))
            {
                txtDropOfLocation_Validating(txtDropOfLocation, new CancelEventArgs());
                Valid = false;
            }
            if(string.IsNullOrEmpty(txtPickupLocation.Text))
            {
                txtPickupLocation_Validating(txtPickupLocation, new CancelEventArgs());
                Valid = false;
            }          
            if(string.IsNullOrEmpty(txtInitialCheckNotes.Text))
            {
                txtInitialCheckNotes_Validating(txtInitialCheckNotes, new CancelEventArgs());
                Valid = false;
            }
            if(string.IsNullOrEmpty(txtPaymentDetails.Text))
            {
                txtPaymentDetails_Validating(txtPaymentDetails, new CancelEventArgs());
                Valid = false;
            }

            return Valid;
        }

        private void frmRentalBooking_Load(object sender, EventArgs e)
        {
            tpVehicleInfo.Enabled = false;
            tpRentalBookingInfo.Enabled = false;

            _ResetDefaultValues();

            if (_Mode == enMode.Update)
                _LoadRentalBookingInfo();
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");

            else
                errorProvider1.SetError(Temp, null);
        }

        private void frmRentalBooking_Activated(object sender, EventArgs e)
        {
            ctrlCustomerCardWithFilter1.txtFilterValueFocus();
        }

        private void ctrlCustomerCardWithFilter1_OnSelectedCustomer(int CustomerID)
        {
            _CustomerID = CustomerID;

            if(_CustomerID == -1)
            {
                btnSetBooking.Enabled = false;
                tpVehicleInfo.Enabled = false;
                tpRentalBookingInfo.Enabled = false;
                ctrlCustomerCardWithFilter1.txtFilterValueFocus();
                return;
            }

            ctrlCustomerCardWithFilter1.txtFilterValueFocus();
        }

        private void ctrlVehicleCardWithFilter1_OnVehicleSelected(object sender, ctrlVehicleCardWithFilter.VehicleSelectedEventArgs e)
        {
            if(e.VehicleInfo == null)
            {
                ctrlVehicleCardWithFilter1.txtMakeNameFocus();
                return;
            }

            if(!e.VehicleInfo.IsAvailableForRent)
            {
                MessageBox.Show("This Vehicle Is Booking", "Booking", MessageBoxButtons.OK, MessageBoxIcon.Error);
                btnNextTabBooking.Enabled = false;
            }

            ctrlVehicleCardWithFilter1.txtMakeNameFocus();
        }

        private void btnNextTab_Click(object sender, EventArgs e)
        {
            if(_Mode == enMode.Update || _CustomerID != -1)
            {
                tpVehicleInfo.Enabled = true;
                tcRentalBooking.SelectedTab = tcRentalBooking.TabPages["tpVehicleInfo"];
                ctrlVehicleCardWithFilter1.txtMakeNameFocus();
                return;
            }

            MessageBox.Show("Select One A Customer", "Select A Customer", MessageBoxButtons.OK, MessageBoxIcon.Error);
            ctrlCustomerCardWithFilter1.txtFilterValueFocus();
        }

        private void btnNextTabBooking_Click(object sender, EventArgs e)
        {
            if(ctrlVehicleCardWithFilter1.VehicleSelectedInfo != null || _Mode == enMode.Update)
            {
                tpRentalBookingInfo.Enabled = true;
                btnSetBooking.Enabled = true;
                tcRentalBooking.SelectedTab = tcRentalBooking.TabPages["tpRentalBookingInfo"];
                txtRentalPricePerDay.Text = ctrlVehicleCardWithFilter1.VehicleSelectedInfo.RentalPricePerDay.ToString();

                //Func<decimal, decimal> TotalDueAmount = t => t * nudInitialRentalDays.Value;
                //lblInitialTotalDueAmount.Text = TotalDueAmount.Invoke(Convert.ToDecimal(txtRentalPricePerDay.Text)).ToString();
                lblInitialTotalDueAmount.Text = _CalculateInitialTotalDueAmount().ToString();
                txtPickupLocation.Focus();
                return;
            }


            MessageBox.Show("Select One A Vehicle", "Select A Vehicle", MessageBoxButtons.OK, MessageBoxIcon.Error);
            ctrlVehicleCardWithFilter1.txtMakeNameFocus();
        }

        private void txtPickupLocation_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtDropOfLocation_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtRentalPricePerDay_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtRentalPricePerDay.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            // Named Function شوف هنا تكرر نفس اللامدا واحنا هنا يعطيني اشارة تكرار نفس التعبير على طول استخدم  
            // لاعادة استخدام نفس الكود وتقليل التكرار
            //Func<decimal, decimal> TotalDueAmount = t => Convert.ToDecimal(txtRentalPricePerDay.Text) + nudInitialRentalDays.Value;
            //lblInitialTotalDueAmount.Text = TotalDueAmount.ToString();

            lblInitialTotalDueAmount.Text = _CalculateInitialTotalDueAmount().ToString();
        }
     
        private void nudInitialRentalDays_ValueChanged(object sender, EventArgs e)
        {
            dtpRentalEndDate.Value = DateTime.Now.AddDays((double)nudInitialRentalDays.Value);

            if(!string.IsNullOrEmpty(txtRentalPricePerDay.Text))
            {
                lblInitialTotalDueAmount.Text = _CalculateInitialTotalDueAmount().ToString();

                //Func<decimal, decimal> TotalDueAmount = t => Convert.ToDecimal(txtRentalPricePerDay.Text) + nudInitialRentalDays.Value;
                //lblInitialTotalDueAmount.Text = TotalDueAmount.ToString();
            }
        }

        private void txtInitialCheckNotes_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void btnSetBooking_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _RentalBooking.CustomerID = ctrlCustomerCardWithFilter1.CustomerSelectedInfo.CustomerID;
            _RentalBooking.VehicleID = ctrlVehicleCardWithFilter1.VehicleSelectedInfo.VehicleID;
            _RentalBooking.RentalStartDate = dtpRentalStartDate.Value;
            _RentalBooking.RentalEndDate = dtpRentalEndDate.Value;
            _RentalBooking.PickupLocation = txtPickupLocation.Text.Trim();
            _RentalBooking.DropOfLocation = txtDropOfLocation.Text.Trim();
            _RentalBooking.InitialRentalDays = (int)nudInitialRentalDays.Value;
            _RentalBooking.RentalPricePerDay = ctrlVehicleCardWithFilter1.VehicleSelectedInfo.RentalPricePerDay;
            _RentalBooking.InitialTotalDueAmount = _RentalBooking.InitialRentalDays * _RentalBooking.RentalPricePerDay;
            _RentalBooking.InitialCheckNotes = txtInitialCheckNotes.Text.Trim();
            _RentalBooking.CreatedByUserID = clsGlobal.CurrentUser.UserID;

            if (_RentalBooking.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);

                // Save Rental Transaction
                if(_Mode == enMode.Add)
                {
                    _RentalTransaction.BookingID = _RentalBooking.BookingID;
                    _RentalTransaction.PaymentDetails = txtPaymentDetails.Text;
                    _RentalTransaction.PaidInitialTotalDueAmount = _RentalBooking.InitialTotalDueAmount;
                    _RentalTransaction.TransactionDate = DateTime.Now;
                    _RentalTransaction.CreatedByUserID = clsGlobal.CurrentUser.UserID;
                    if (!_RentalTransaction.Save())
                        MessageBox.Show("Doesn't Save Rental Transaction", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);

                    VehicleBooking(_RentalBooking.BookingID);
                }

                lblBookingID.Text = _RentalBooking.BookingID.ToString();
                lblTitle.Text = "Update Rental Booking";
                _Mode = enMode.Update;               
                RaiseOnRentalBookingSelected(_RentalBooking);
            }

            else
                MessageBox.Show("Doesn't Save Data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void txtPaymentDetails_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void dtpRentalEndDate_ValueChanged(object sender, EventArgs e)
        {
            //nudInitialRentalDays.Value = dtpRentalEndDate.Value.Day - dtpRentalStartDate.Value.Day;
        }
    }
}