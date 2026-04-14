using CRMS.GlobalClasses;
using CRMS.Vehicle.Controls;
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
    public partial class frmVehicleReturn : Form
    {
        private int? _VehicleID = null;
        private int? _BookingID = null;

        private clsVehicleReturn _VehicleReturn = null;
        private clsRentalTransaction _RentalTransaction = null;

        public frmVehicleReturn()
        {
            InitializeComponent();
        }

        private void frmVehicleReturn_Load(object sender, EventArgs e)
        {
            tpRentalBookingInfo.Enabled = false;
            tpVehicleReturnInfo.Enabled = false;
            _ResetDefaultValues();
        }

        private int _CalculateTotalDueAmount()
        {
            return (int)(ctrlVehicleCardWithFilter1.VehicleSelectedInfo.RentalPricePerDay * nudInitialRentalDays.Value) + Convert.ToInt32(txtAdditionalCharges.Text);
        }

        public override bool ValidateChildren()
        {
            bool Valid = true;

            if(string.IsNullOrEmpty(txtAdditionalCharges.Text))
            {
                txtAdditionalCharges_Validating(txtAdditionalCharges, new CancelEventArgs());
                Valid = false;
            }
            if(string.IsNullOrEmpty(txtMileage.Text))
            {
                txtMileage_Validating(txtMileage, new CancelEventArgs());
                Valid = false;
            }
            if(string.IsNullOrEmpty(txtFinalCheckNotes.Text))
            {
                txtFinalCheckNotes_Validating(txtFinalCheckNotes, new CancelEventArgs());
                Valid = false;
            }
            return Valid;
        }

        private void _ResetDefaultValues()
        {
            lblReturnID.Text = "[???]";
            txtAdditionalCharges.Text = "0";
            txtMileage.Text = "";
            dtpActualReturnDate.MinDate = DateTime.Now;
            dtpActualReturnDate.Value = dtpActualReturnDate.MinDate;
            lblConsumedMileage.Text = "[???]";
            lblActualTotalDueAmount.Text = "[???]";
            txtFinalCheckNotes.Text = "";
        }

        private bool _IsNumber(object sender, KeyPressEventArgs e)
        {
            return (e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back);
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");
            else
                errorProvider1.SetError(Temp, null);
        }

        private void _DisabledControls (bool tpRentalBookingInfoEnabled, bool tpVehicleReturnInfoEnabled, bool btnSaveEnabled, bool btnNextToVehicleReturnInfoEnabled)
        {
            tpRentalBookingInfo.Enabled = tpRentalBookingInfoEnabled;
            tpVehicleReturnInfo.Enabled = tpVehicleReturnInfoEnabled;
            btnSave.Enabled = btnSaveEnabled;
            btnNextToVehicleReturnInfo.Enabled = btnNextToVehicleReturnInfoEnabled;
        }

        private void ctrlVehicleCardWithFilter1_OnVehicleSelected(object sender, ctrlVehicleCardWithFilter.VehicleSelectedEventArgs e)
        {
            if(e.VehicleInfo == null)
            {
                _DisabledControls(false, false, false, false);
                ctrlVehicleCardWithFilter1.txtMakeNameFocus();
                return;
            }

            if(e.VehicleInfo.IsAvailableForRent)
            {
                _DisabledControls(false, false, false, false);
                MessageBox.Show("This Vehicle Is Not Booking", "Not Booking", MessageBoxButtons.OK, MessageBoxIcon.Error);
                ctrlVehicleCardWithFilter1.txtMakeNameFocus();
                return;
            }

            ctrlRentalBookingCard1.LoadRentalBookingInfoByVehicleID(e.VehicleInfo.VehicleID);
            _VehicleID = e.VehicleInfo.VehicleID;
            ctrlVehicleCardWithFilter1.txtMakeNameFocus();
        }

        private void btnNextToRentalBookingInfo_Click(object sender, EventArgs e)
        {
            if(_VehicleID != null)
            {
                tpRentalBookingInfo.Enabled = true;
                tcVehicleReturn.SelectedTab = tcVehicleReturn.TabPages["tpRentalBookingInfo"];
                return;
            }

            MessageBox.Show("Select One A Vehicle", "Select A Vehicle", MessageBoxButtons.OK, MessageBoxIcon.Error);
            ctrlVehicleCardWithFilter1.txtMakeNameFocus();
        }

        private void btnNextToVehicleReturnInfo_Click(object sender, EventArgs e)
        {
            if (_BookingID != null)
            {
                if (_VehicleID != null)
                {
                    tpVehicleReturnInfo.Enabled = true;
                    tcVehicleReturn.SelectedTab = tcVehicleReturn.TabPages["tpVehicleReturnInfo"];                    
                    return;
                }

                MessageBox.Show("Select One A Rental Booking", "Select A Rental Booking", MessageBoxButtons.OK, MessageBoxIcon.Error);
                tcVehicleReturn.SelectedTab = tcVehicleReturn.TabPages["tpVehicleInfo"];
            }
        }

        private void ctrlRentalBookingCard1_OnBookingChanged(int BookingID)
        {            
            if (_BookingID == -1)
                return;

            _BookingID = BookingID;
            _RentalTransaction = clsRentalTransaction.FindByBookingID(_BookingID ?? -1);
        }

        private decimal _CalculateTotalRemaining()
        {
            if (dtpActualReturnDate.Value <= ctrlRentalBookingCard1.RentalBookingSelectedInfo.RentalEndDate)
                return 0;

            if (_CalculateTotalDueAmount() == ctrlRentalBookingCard1.RentalBookingSelectedInfo.InitialTotalDueAmount)
                return 0;

           return (decimal)(_RentalTransaction.PaidInitialTotalDueAmount - _RentalTransaction.ActualTotalDueAmount);
        }

        private decimal _CalculateTotalRefundedAmount()
        {
            if (dtpActualReturnDate.Value < ctrlRentalBookingCard1.RentalBookingSelectedInfo.RentalEndDate)
            {
                if (_CalculateTotalDueAmount() == ctrlRentalBookingCard1.RentalBookingSelectedInfo.InitialTotalDueAmount)
                    return 0;

                return (decimal)(_RentalTransaction.PaidInitialTotalDueAmount - _RentalTransaction.ActualTotalDueAmount);
            }

            //if (dtpActualReturnDate.Value > ctrlRentalBookingCard1.RentalBookingSelectedInfo.RentalEndDate)
            return 0;
        }

        private void txtMileage_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtMileage.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if (Convert.ToInt32(txtMileage.Text) > ctrlVehicleCardWithFilter1.VehicleSelectedInfo.Mileage)
            {
                e.Cancel = false;
                errorProvider1.SetError(txtMileage, null);
                lblConsumedMileage.Text = (Convert.ToInt32(txtMileage.Text) - ctrlVehicleCardWithFilter1.VehicleSelectedInfo.Mileage).ToString();
            }
            else
            {
                e.Cancel = true;
                errorProvider1.SetError(txtMileage, "Wrong Mileage");
            }
        }

        private void txtAdditionalCharges_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtAdditionalCharges.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            lblActualTotalDueAmount.Text = _CalculateTotalDueAmount().ToString();
        }

        private void txtFinalCheckNotes_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtMileage_KeyPress(object sender, KeyPressEventArgs e) => _IsNumber(sender, e);

        private void txtAdditionalCharges_KeyPress(object sender, KeyPressEventArgs e)
        {
            _IsNumber(sender, e);          
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _VehicleReturn = new clsVehicleReturn();

            _VehicleReturn.BookingID = ctrlRentalBookingCard1.BookingID;
            _VehicleReturn.VehicleID = ctrlVehicleCardWithFilter1.VehicleSelectedInfo.VehicleID;
            _VehicleReturn.ActualReturnDate = dtpActualReturnDate.Value;
            _VehicleReturn.ActualRentalDays = (int)nudInitialRentalDays.Value;
            _VehicleReturn.Mileage = Convert.ToInt32(txtMileage.Text);
            _VehicleReturn.ConsumedMileage = _VehicleReturn.Mileage - ctrlVehicleCardWithFilter1.VehicleSelectedInfo.Mileage;
            _VehicleReturn.FinalCheckNotes = txtFinalCheckNotes.Text;
            _VehicleReturn.AdditionalCharges = Convert.ToDecimal(txtAdditionalCharges.Text);
            _VehicleReturn.ActualTotalDueAmount = Convert.ToDecimal(_CalculateTotalDueAmount());
            _VehicleReturn.CreatedByUserID = clsGlobal.CurrentUser.UserID;

            if (_VehicleReturn.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblReturnID.Text = _VehicleReturn.ReturnID.ToString();
                btnSave.Enabled = false;
                llShowVehicleReturnInfo.Enabled = true;

                if (_RentalTransaction != null)
                {
                    _RentalTransaction.ReturnID = _VehicleReturn.ReturnID;
                    _RentalTransaction.ActualTotalDueAmount = _VehicleReturn.ActualTotalDueAmount;
                    _RentalTransaction.TotalRemaining = _CalculateTotalRemaining();
                    _RentalTransaction.TotalRefundedAmount = _CalculateTotalRefundedAmount();
                    _RentalTransaction.UpdatedTransactionDate = DateTime.Now;
                    _RentalTransaction.UpdatedByUserID = clsGlobal.CurrentUser.UserID;

                    if (!_RentalTransaction.UpdateRentalTransactionAfterVehicleReturn())
                    {
                        MessageBox.Show("There Error In Update Rental Transaction", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    lblTotalRemaining.Text = ((int)_RentalTransaction.TotalRemaining).ToString();
                    lblTotalRefundedAmount.Text = ((int)_RentalTransaction.TotalRefundedAmount).ToString();
                }

            }
        }

        private void txtAdditionalCharges_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtAdditionalCharges.Text))
            {
                txtAdditionalCharges.Text = "0";
                return;
            }
        }

        private void frmVehicleReturn_Activated(object sender, EventArgs e)
        {
            ctrlVehicleCardWithFilter1.txtMakeNameFocus();
        }

        private void nudInitialRentalDays_ValueChanged(object sender, EventArgs e)
        {
            lblActualTotalDueAmount.Text = _CalculateTotalDueAmount().ToString();
        }

        private void dtpActualReturnDate_ValueChanged(object sender, EventArgs e)
        {
            int? Days = dtpActualReturnDate.Value.Day - ctrlRentalBookingCard1.RentalBookingSelectedInfo?.RentalStartDate.Day;

            if (Days == 0 || Days < 0 || Days == null)
                Days = 1;

            nudInitialRentalDays.Value = (int)Days;
        }

        private void llShowVehicleReturnInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            int BookingID = ctrlRentalBookingCard1.BookingID;
            int ReturnID = Convert.ToInt32(lblReturnID.Text);

            frmShowVehicleReturnInfo showVehicleReturnInfo = new frmShowVehicleReturnInfo(BookingID, ReturnID);
            showVehicleReturnInfo.ShowDialog();
        }
    }
}