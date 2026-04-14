using CRMS.GlobalClasses;
using CRMS_Business;
using System;
using System.Windows.Forms;

namespace CRMS.RentalTransaction.Controls
{
    public partial class ctrlRentalTransactionCard : UserControl
    {
        private int _TransactionID = -1;
        public int TransactionID => _TransactionID;

        private clsRentalTransaction _RentalTransaction = null;
        public clsRentalTransaction RentalTransactionSelectedInfo => _RentalTransaction;

        private void _ResetDefaultValues()
        {
            lblTransactionID.Text = "[???]";
            lblReturnID.Text = "[???]";
            lblBookingID.Text = "[???]";
            lblPaymentDetails.Text = "[???]";
            lblPaidInitialTotalDueAmount.Text = "[???]";
            lblActualTotalDueAmount.Text = "[???]";
            lblTotalRemaining.Text = "[???]";
            lblTotalRefundedAmount.Text = "[???]";
            lblTransactionDate.Text = "[???]";
            lblCreatedBy.Text = "[???]";
            lblUpdatedTransactionDate.Text = "[???]";
            lblUpdatedBy.Text = "[???]";
        }

        private object CheckValue(object Value, Predicate<object> predicate) => predicate(Value) ? null : (Value);

        private string Processor(object Value) => Value == null ? "[???]" : Convert.ToInt32(Value).ToString();

        private void _FillRentalTransactionInfoInControls()
        {
            _TransactionID = _RentalTransaction.TransactionID;
            ctrlVehicleReturnCard1.LoadVehicleReturnInfo(_RentalTransaction.BookingID, _RentalTransaction.ReturnID ?? -1);
            lblTransactionID.Text = _RentalTransaction.TransactionID.ToString();
            lblReturnID.Text = Processor(CheckValue(_RentalTransaction.ReturnID, e => e == null));
            lblBookingID.Text = _RentalTransaction.BookingID.ToString();
            lblPaymentDetails.Text = _RentalTransaction.PaymentDetails;
            lblPaidInitialTotalDueAmount.Text = ((int)_RentalTransaction.PaidInitialTotalDueAmount).ToString();
            lblActualTotalDueAmount.Text = Processor(CheckValue(_RentalTransaction.ActualTotalDueAmount, e => e == null));
            lblTotalRemaining.Text = Processor(CheckValue(_RentalTransaction.TotalRemaining, e => e == null));
            lblTotalRefundedAmount.Text = Processor(CheckValue(_RentalTransaction.TotalRefundedAmount, e => e == null));
            lblTransactionDate.Text = clsFormat.DateToString(_RentalTransaction.TransactionDate);
            lblCreatedBy.Text = _RentalTransaction.CreatedByUserID.ToString();
            
            if (CheckValue(_RentalTransaction.UpdatedTransactionDate, e => e == null) != null)
                lblUpdatedTransactionDate.Text = clsFormat.DateToString((DateTime)_RentalTransaction.UpdatedTransactionDate);

            lblUpdatedBy.Text = Processor(CheckValue(_RentalTransaction.UpdatedByUserID, e => e == null));
        }

        public void LoadRentalTransactionInfo(int TransactionID)
        {
            _RentalTransaction = clsRentalTransaction.Find(TransactionID);

            if(_RentalTransaction == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Transaction With ID = {TransactionID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillRentalTransactionInfoInControls();
        }

        public ctrlRentalTransactionCard()
        {
            InitializeComponent();
        }      
    }
}