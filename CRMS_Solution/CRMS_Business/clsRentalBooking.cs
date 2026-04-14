using CRMS_DataAccess;
using System;
using System.Data;

namespace CRMS_Business
{
    public class clsRentalBooking
    {
        public enum enMode { Add = 0 , Update = 1 };
        public enMode Mode = enMode.Add;

        public int BookingID { get; set; }
        public int CustomerID { get; set; }
        public int VehicleID { get; set; }
        public DateTime RentalStartDate { get; set; }
        public DateTime RentalEndDate { get; set; }
        public string PickupLocation { get; set; }
        public string DropOfLocation { get; set; }
        public int InitialRentalDays { get; set; }
        public decimal RentalPricePerDay { get; set; }
        public decimal InitialTotalDueAmount { get; set; }
        public string InitialCheckNotes { get; set; }
        public int CreatedByUserID { get; set; }

        public clsCustomer CustomerInfo { get; set; }
        public clsVehicle VehicleInfo { get; set; }
        public clsUser UserInfo { get; set; }

        public clsRentalBooking()
        {
            BookingID = -1;
            CustomerID = -1;
            VehicleID = -1;
            RentalStartDate = DateTime.Now;
            RentalEndDate = RentalStartDate.AddDays(InitialRentalDays);
            PickupLocation = "";
            DropOfLocation = "";
            InitialRentalDays = 0;
            RentalPricePerDay = 0;
            InitialTotalDueAmount = 0;
            InitialCheckNotes = "";
            CreatedByUserID = -1;
            Mode = enMode.Add;
        }

        private clsRentalBooking
            (
                int BookingID, int CustomerID, int VehicleID, DateTime RentalStartDate, DateTime RentalEndDate,
                string PickupLocation, string DropOfLocation, int InitialRentalDays,
                decimal RentalPricePerDay, decimal InitialTotalDueAmount, 
                string InitialCheckNotes, int CreatedByUserID
            )
        {
            this.BookingID = BookingID;
            this.CustomerID = CustomerID;
            this.VehicleID = VehicleID;
            this.RentalStartDate = RentalStartDate;
            this.RentalEndDate = RentalEndDate;
            this.PickupLocation = PickupLocation;
            this.DropOfLocation = DropOfLocation;
            this.InitialRentalDays = InitialRentalDays;
            this.RentalPricePerDay = RentalPricePerDay;
            this.InitialTotalDueAmount = InitialTotalDueAmount;
            this.InitialCheckNotes = InitialCheckNotes;
            this.CreatedByUserID = CreatedByUserID;
            CustomerInfo = clsCustomer.Find(this.CustomerID);
            VehicleInfo = clsVehicle.Find(this.VehicleID);
            UserInfo = clsUser.FindByUserID(this.CreatedByUserID);
            Mode = enMode.Update;
        }


        public static clsRentalBooking Find(int BookingID)
        {
            int CustomerID = -1, VehicleID = -1, CreatedByUserID = -1, InitialRentalDays = 0;
            DateTime RentalStartDate = DateTime.Now, RentalEndDate = DateTime.Now.AddDays(2);
            string PickupLocation = "", DropOfLocation = "", InitialCheckNotes = "";
            decimal RentalPricePerDay = 0, InitialTotalDueAmount = 0;

            bool IsFind = clsRentalBookingData.GetRentalBookingInfoByID
                (
                    BookingID, ref CustomerID, ref VehicleID, ref RentalStartDate, ref RentalEndDate,
                    ref PickupLocation, ref DropOfLocation, ref InitialRentalDays,
                    ref RentalPricePerDay, ref InitialTotalDueAmount, ref InitialCheckNotes, ref CreatedByUserID
                );

            if (IsFind)
                return new clsRentalBooking
                    (
                        BookingID, CustomerID, VehicleID, RentalStartDate, RentalEndDate,
                        PickupLocation, DropOfLocation, InitialRentalDays, RentalPricePerDay,
                        InitialTotalDueAmount, InitialCheckNotes, CreatedByUserID
                    );

            return null;
        }

        public static clsRentalBooking FindByVehicleID(int VehicleID)
        {
            int CustomerID = -1, BookingID = -1, CreatedByUserID = -1, InitialRentalDays = 0;
            DateTime RentalStartDate = DateTime.Now, RentalEndDate = DateTime.Now.AddDays(2);
            string PickupLocation = "", DropOfLocation = "", InitialCheckNotes = "";
            decimal RentalPricePerDay = 0, InitialTotalDueAmount = 0;

            bool IsFind = clsRentalBookingData.GetRentalBookingInfoByVehicleID
                (
                    VehicleID, ref BookingID, ref CustomerID, ref RentalStartDate, ref RentalEndDate,
                    ref PickupLocation, ref DropOfLocation, ref InitialRentalDays,
                    ref RentalPricePerDay, ref InitialTotalDueAmount, ref InitialCheckNotes, ref CreatedByUserID
                );

            if (IsFind)
                return new clsRentalBooking
                    (
                        BookingID, CustomerID, VehicleID, RentalStartDate, RentalEndDate,
                        PickupLocation, DropOfLocation, InitialRentalDays, RentalPricePerDay,
                        InitialTotalDueAmount, InitialCheckNotes, CreatedByUserID
                    );

            return null;
        }

        private bool _AddNewBooking()
        {
            this.BookingID = clsRentalBookingData.AddNewBooking
                (
                    this.CustomerID, this.VehicleID, this.RentalStartDate, this.RentalEndDate,
                    this.PickupLocation, this.DropOfLocation, this.InitialRentalDays, this.RentalPricePerDay,
                    this.InitialTotalDueAmount, this.InitialCheckNotes, this.CreatedByUserID
                );

            return (this.BookingID != -1);
        }

        private bool _UpdateBooking()
        {
            return clsRentalBookingData.UpdateBooking
                (
                    this.BookingID, this.CustomerID, this.VehicleID, this.RentalStartDate, this.RentalEndDate,
                    this.PickupLocation, this.DropOfLocation, this.InitialRentalDays, this.RentalPricePerDay,
                    this.InitialTotalDueAmount, this.InitialCheckNotes, this.CreatedByUserID
                );
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewBooking())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateBooking();
            }
            return false;
        }

        public static bool DeleteBooking(int BookingID) => clsRentalBookingData.DeleteBooking(BookingID);

        public static DataTable GetAllRentalsBooking() => clsRentalBookingData.GetAllRentalsBooking();
    }
}