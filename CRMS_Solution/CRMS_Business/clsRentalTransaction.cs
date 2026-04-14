using CRMS_DataAccess;
using System;
using System.Data;

namespace CRMS_Business
{
    public class clsRentalTransaction
    {
        public enum enMode { Add = 0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int TransactionID { get; set; }
        public int BookingID { get; set; }
        public int? ReturnID { get; set; }
        public string PaymentDetails { get; set; }
        public decimal PaidInitialTotalDueAmount { get; set; }
        public decimal? ActualTotalDueAmount { get; set; }
        public decimal? TotalRemaining {  get; set; }
        public decimal? TotalRefundedAmount { get; set; }
        public DateTime TransactionDate { get; set; }
        public int CreatedByUserID { get; set; }
        public DateTime? UpdatedTransactionDate { get; set; }
        public int? UpdatedByUserID { get; set; }

        public clsRentalBooking RentalBookingInfo { get; set; }
        public clsVehicleReturn VehicleReturnInfo { get; set; }
        public clsUser CreatedByUserInfo { get; set; }
        public clsUser UpdatedByUserInfo { get; set; }


        public clsRentalTransaction()
        {
            TransactionID = -1;
            BookingID = -1;
            ReturnID = null;
            PaymentDetails = null;
            PaidInitialTotalDueAmount = 0;
            ActualTotalDueAmount = null;
            TotalRemaining = null;
            TotalRefundedAmount = null;
            TransactionDate = DateTime.Now;
            CreatedByUserID = -1;
            UpdatedTransactionDate = null;
            UpdatedByUserID = null;
            Mode = enMode.Add;
        }

        private clsRentalTransaction
            (
               int TransactionID, int BookingID, int? ReturnID, string PaymentDetails,
               decimal PaidInitialTotalDueAmount, decimal? ActualTotalDueAmount, decimal? TotalRemaining,
               decimal? TotalRefundedAmount, DateTime TransactionDate, int CreatedByUserID,
               DateTime? UpdatedTransactionDate, int? UpdatedByUserID
            )
        {
            this.TransactionID = TransactionID;
            this.BookingID = BookingID;
            this.ReturnID = ReturnID;
            this.PaymentDetails = PaymentDetails;
            this.PaidInitialTotalDueAmount = PaidInitialTotalDueAmount;
            this.ActualTotalDueAmount = ActualTotalDueAmount;
            this.TotalRemaining = TotalRemaining;
            this.TotalRefundedAmount = TotalRefundedAmount;
            this.TransactionDate = TransactionDate;
            this.CreatedByUserID = CreatedByUserID;
            this.UpdatedTransactionDate = UpdatedTransactionDate;
            this.UpdatedByUserID = UpdatedByUserID;
            RentalBookingInfo = clsRentalBooking.Find(this.BookingID);
            VehicleReturnInfo = clsVehicleReturn.Find(this.ReturnID ?? -1);
            CreatedByUserInfo = clsUser.FindByUserID(this.CreatedByUserID);
            UpdatedByUserInfo = clsUser.FindByUserID(this.UpdatedByUserID ?? -1);
            Mode = enMode.Update;
        }


        public static clsRentalTransaction Find(int TransactionID)
        {
            int BookingID = -1, CreatedByUserID = -1;
            int? ReturnID = null, UpdateByUserID = null;
            decimal PaidInitialTotalDueAmount = 0;
            decimal? ActualTotalDueAmount = null, TotalRemaining = null, TotalRefundedAmount = null;
            string PaymentDetails = null;
            DateTime? UpdatedTransactionDate = null;
            DateTime TransactionDate = DateTime.Now;

            bool IsFind = clsRentalTransactionData.GetRentalTransactionInfoByID
                (
                    TransactionID, ref BookingID, ref ReturnID, ref PaymentDetails, ref PaidInitialTotalDueAmount,
                    ref ActualTotalDueAmount, ref TotalRemaining, ref TotalRefundedAmount, ref TransactionDate,
                    ref CreatedByUserID, ref UpdatedTransactionDate, ref UpdateByUserID
                );

            if (IsFind)
                return new clsRentalTransaction
                    (
                        TransactionID, BookingID, ReturnID, PaymentDetails, PaidInitialTotalDueAmount,
                        ActualTotalDueAmount, TotalRemaining, TotalRefundedAmount, TransactionDate,
                        CreatedByUserID, UpdatedTransactionDate, UpdateByUserID
                    );

            return null;
        }


        public static clsRentalTransaction FindByBookingID(int BookingID)
        {
            int TransactionID = -1, CreatedByUserID = -1;
            int? ReturnID = null, UpdateByUserID = null;
            decimal PaidInitialTotalDueAmount = 0;
            decimal? ActualTotalDueAmount = null, TotalRemaining = null, TotalRefundedAmount = null;
            string PaymentDetails = null;
            DateTime? UpdatedTransactionDate = null;
            DateTime TransactionDate = DateTime.Now;

            bool IsFind = clsRentalTransactionData.GetRentalTransactionInfoByBookingID
                (
                    BookingID, ref TransactionID, ref ReturnID, ref PaymentDetails, ref PaidInitialTotalDueAmount,
                    ref ActualTotalDueAmount, ref TotalRemaining, ref TotalRefundedAmount, ref TransactionDate,
                    ref CreatedByUserID, ref UpdatedTransactionDate, ref UpdateByUserID
                );

            if (IsFind)
                return new clsRentalTransaction
                    (
                        TransactionID, BookingID, ReturnID, PaymentDetails, PaidInitialTotalDueAmount,
                        ActualTotalDueAmount, TotalRemaining, TotalRefundedAmount, TransactionDate,
                        CreatedByUserID, UpdatedTransactionDate, UpdateByUserID
                    );

            return null;
        }

        private bool _AddNewRentalTransaction()
        {
            this.TransactionID = clsRentalTransactionData.AddNewRentalTransaction
                (
                    this.BookingID, this.PaymentDetails, this.PaidInitialTotalDueAmount, this.TransactionDate, this.CreatedByUserID
                );
            return (this.TransactionID != -1);
        }

        private bool _UpdateRentalTransaction()
        {
            return clsRentalTransactionData.UpdateRentalTransaction(TransactionID, BookingID, PaymentDetails, PaidInitialTotalDueAmount);
        }

        public bool UpdateRentalTransactionAfterVehicleReturn()
        {
            return clsRentalTransactionData.UpdateRentalTransactionAfterVehicleReturn
                (
                    this.TransactionID, this.ReturnID, this.ActualTotalDueAmount, this.TotalRemaining,
                    this.TotalRefundedAmount, this.UpdatedTransactionDate, this.UpdatedByUserID
                );
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewRentalTransaction())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateRentalTransaction();                    
            }
            return false;
        }

        public static bool DeleteRentalTransaction(int TransactionID)
        {
            return clsRentalTransactionData.DeleteRentalTransaction(TransactionID);
        }

        public static DataTable GetAllRentalTransaction() => clsRentalTransactionData.GetAllRentalTransaction();
       
        public decimal _CalculateTotalRemaining(DateTime ActualReturnDate, DateTime RentalEndDate, decimal InitialTotalDueAmount)
        {
            if (ActualReturnDate <= RentalEndDate)
                return 0;

            if (this.ActualTotalDueAmount == InitialTotalDueAmount)
                return 0;

            return (decimal)(this.PaidInitialTotalDueAmount - this.ActualTotalDueAmount);
        }

        public static string GetPaymentDetailsByBookingID(int BookingID)
        {
            return clsRentalTransactionData.GetPaymentDetailsByBookingID(BookingID);
        }
    }
}