using CRMS_DataAccess;
using System;
using System.Data;

namespace CRMS_Business
{
    public class clsVehicleReturn
    {
        public enum enMode { Add = 0, Update = 1};
        public enMode Mode = enMode.Add;

        public int ReturnID { get; set; }
        public DateTime ActualReturnDate { get; set; }
        public int ActualRentalDays { get; set; }
        public int Mileage { get; set; }
        public int ConsumedMileage { get; set; }
        public string FinalCheckNotes { get; set; }
        public decimal AdditionalCharges { get; set; }
        public decimal ActualTotalDueAmount { get; set; }
        public int CreatedByUserID { get; set; }

        // خصائص لللاستخدام لتحديث حالة المركبة وتحديث حالة الاستئجار
        public int VehicleID { get; set; }
        public int BookingID { get; set; }

        public clsUser UserInfo { get; set; }

        public clsVehicleReturn()
        {
            ReturnID = -1;
            ActualReturnDate = DateTime.Now;
            ActualRentalDays = -1;
            Mileage = -1;
            ConsumedMileage = -1;
            FinalCheckNotes = null;
            AdditionalCharges = 0;
            ActualTotalDueAmount = -1;
            CreatedByUserID = -1;
            Mode = enMode.Add;
        }

        private clsVehicleReturn
            (
                int ReturnID, DateTime ActualReturnDate, int ActualRentalDays, int Mileage,
                int ConsumedMileage, string FinalCheckNotes, decimal AdditionalCharges,
                decimal ActualTotalDueAmount, int CreatedByUserID
            )
        {
            this.ReturnID = ReturnID;
            this.ActualReturnDate = ActualReturnDate;
            this.ActualRentalDays = ActualRentalDays;
            this.Mileage = Mileage;
            this.ConsumedMileage = ConsumedMileage;
            this.FinalCheckNotes = FinalCheckNotes;
            this.AdditionalCharges = AdditionalCharges;
            this.ActualTotalDueAmount = ActualTotalDueAmount;
            this.CreatedByUserID = CreatedByUserID;
            UserInfo = clsUser.FindByUserID(this.CreatedByUserID);
            Mode = enMode.Update;
        }


        public static clsVehicleReturn Find(int ReturnID)
        {
            DateTime ActualReturnDate = DateTime.Now;
            int ActualRentalDays = -1, Mileage = -1, ConsumedMileage = -1, CreatedByUserID = -1;
            string FinalCheckNotes = "";
            decimal AdditionalCharges = -1, ActualTotalDueAmount = -1;

            bool IsFind = clsVehicleReturnData.GetVehicleReturnInfoByID
                (
                    ReturnID, ref ActualReturnDate, ref ActualRentalDays, ref Mileage,
                    ref ConsumedMileage, ref FinalCheckNotes, ref AdditionalCharges, ref ActualTotalDueAmount,
                    ref CreatedByUserID
                );

            if (IsFind)
                return new clsVehicleReturn
                    (
                        ReturnID, ActualReturnDate, ActualRentalDays, Mileage, ConsumedMileage,
                        FinalCheckNotes, AdditionalCharges, ActualTotalDueAmount, CreatedByUserID
                    );

            return null;
        }

        private bool _AddNewVehicleReturn()
        {
            this.ReturnID = clsVehicleReturnData.AddNewVehicleReturn
                (
                    this.BookingID, this.VehicleID, this.ActualReturnDate, this.ActualRentalDays, this.Mileage,
                    this.ConsumedMileage, this.FinalCheckNotes, this.AdditionalCharges, this.ActualTotalDueAmount,
                    this.CreatedByUserID
                );
            return (this.ReturnID != -1);
        }

        private bool _UpdateVehicleReturn()
        {
            return clsVehicleReturnData.UpdateVehicleReturn
                (
                    this.ReturnID, this.ActualReturnDate, this.ActualRentalDays, this.Mileage,
                    this.ConsumedMileage, this.FinalCheckNotes, this.AdditionalCharges, this.ActualTotalDueAmount,
                    this.CreatedByUserID
                );
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewVehicleReturn())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateVehicleReturn();
            }
            return false;
        }

        public static bool DeleteVehicleReturn(int ReturnID) => clsVehicleReturnData.DeleteVehicleReturn(ReturnID);

        public static DataTable GetAllVehiclesReturn() => clsVehicleReturnData.GetAllVehiclesReturn();
    }
}