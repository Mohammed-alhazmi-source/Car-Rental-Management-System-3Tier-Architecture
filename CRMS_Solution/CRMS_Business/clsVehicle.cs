using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsVehicle
    {
        public enum enMode { Add = 0, Update = 1};
        public enMode Mode = enMode.Add;

        public int VehicleID { get; set; }
        public int MakeID { get; set; }
        public int ModelID { get; set; }
        public int Year { get; set; }
        public int Mileage { get; set; }
        public int FuelTypeID { get; set; }
        public int PlateNumber { get; set; }
        public int CarCategoryID { get; set; }
        public decimal RentalPricePerDay { get; set; }
        public bool IsAvailableForRent {  get; set; }
        public int CreatedByUserID { get; set; }
        public string ImagePath { get; set; }

        public clsMake MakeInfo { get; set; }
        public clsMakeModel ModelInfo { get; set; }
        public clsFuelType FuelTypeInfo { get; set; }
        public clsVehicleCategory CategoryInfo { get; set; }
        public clsUser CreatedByUserInfo { get; set; }


        public clsVehicle()
        {
            VehicleID = -1;
            MakeID = -1;
            ModelID = -1;
            Year = -1;
            Mileage = -1;
            FuelTypeID = -1;
            PlateNumber = -1;
            CarCategoryID = -1;
            RentalPricePerDay = 0;
            IsAvailableForRent = true;
            CreatedByUserID = -1;            
            ImagePath = null;
            Mode = enMode.Add;
        }


        private clsVehicle
            (
                int VehicleID, int MakeID, int ModelID, int Year, int Mileage, int FuelTypeID, int PlateNumber,
                int CarCategoryID, decimal RentalPricePerDay, bool IsAvailableForRent, 
                int CreatedByUserID, string ImagePath
            )
        {
            this.VehicleID = VehicleID;
            this.MakeID = MakeID;
            this.ModelID = ModelID;
            this.Year = Year;
            this.Mileage = Mileage;
            this.FuelTypeID = FuelTypeID;
            this.PlateNumber = PlateNumber;
            this.CarCategoryID = CarCategoryID;
            this.RentalPricePerDay = RentalPricePerDay;
            this.IsAvailableForRent = IsAvailableForRent;
            this.CreatedByUserID = CreatedByUserID;
            this.ImagePath = ImagePath;

            MakeInfo = clsMake.Find(this.MakeID);
            ModelInfo = clsMakeModel.Find(this.ModelID);
            FuelTypeInfo = clsFuelType.Find(this.FuelTypeID);
            CategoryInfo = clsVehicleCategory.Find(this.CarCategoryID);
            CreatedByUserInfo = clsUser.FindByUserID(this.CreatedByUserID);            

            Mode = enMode.Update;
        }


        public static clsVehicle Find(int VehicleID)
        {
            int PlateNumber = -1, MakeID = -1, ModelID = -1, Year = -1, Mileage = -1, FuelTypeID = -1, CarCategoryID = -1, CreatedByUserID = -1;
            string ImagePath = null;
            decimal RentalPricePerDay = 0;
            bool IsAvailableForRent = false;

            bool IsFind = clsVehicleData.GetVehicleInfoByID
                (
                    VehicleID, ref MakeID, ref ModelID, ref Year, ref Mileage, ref FuelTypeID,
                    ref PlateNumber, ref CarCategoryID, ref RentalPricePerDay, ref IsAvailableForRent,
                    ref CreatedByUserID, ref ImagePath
                );

            if (IsFind)
                return new clsVehicle
                    (
                        VehicleID, MakeID, ModelID, Year, Mileage, FuelTypeID, PlateNumber, CarCategoryID,
                        RentalPricePerDay, IsAvailableForRent, CreatedByUserID, ImagePath
                    );

            return null;
        }

        public static clsVehicle Find(int VehicleID, int MakeID, int ModelID)
        {
            int PlateNumber = -1,  Year = -1, Mileage = -1, FuelTypeID = -1, CarCategoryID = -1, CreatedByUserID = -1;
            string ImagePath = null;
            decimal RentalPricePerDay = 0;
            bool IsAvailableForRent = false;

            bool IsFind = clsVehicleData.GetVehicleInfoByIDAndMakeIDAndModelID
                (
                    VehicleID, MakeID, ModelID, ref Year, ref Mileage, ref FuelTypeID,
                    ref PlateNumber, ref CarCategoryID, ref RentalPricePerDay, ref IsAvailableForRent,
                    ref CreatedByUserID, ref ImagePath
                );

            if (IsFind)
                return new clsVehicle
                    (
                        VehicleID, MakeID, ModelID, Year, Mileage, FuelTypeID, PlateNumber, CarCategoryID,
                        RentalPricePerDay, IsAvailableForRent, CreatedByUserID, ImagePath
                    );

            return null;
        }

        public static clsVehicle Find(string MakeName, string ModelName)
        {
            int VehicleID = -1, MakeID = -1, ModelID = -1, PlateNumber = -1, Year = -1, Mileage = -1, FuelTypeID = -1, CarCategoryID = -1, CreatedByUserID = -1;
            string ImagePath = null;
            decimal RentalPricePerDay = 0;
            bool IsAvailableForRent = false;

            bool IsFind = clsVehicleData.GetVehicleInfoByMakeNameAndModelName
                (
                    MakeName, ModelName, ref VehicleID, ref MakeID, ref ModelID, ref Year, ref Mileage, ref FuelTypeID,
                    ref PlateNumber, ref CarCategoryID, ref RentalPricePerDay, ref IsAvailableForRent,
                    ref CreatedByUserID, ref ImagePath
                );

            if (IsFind)
                return new clsVehicle
                    (
                        VehicleID, MakeID, ModelID, Year, Mileage, FuelTypeID, PlateNumber, CarCategoryID,
                        RentalPricePerDay, IsAvailableForRent, CreatedByUserID, ImagePath
                    );

            return null;
        }

        private bool _AddNewVehicle()
        {
            this.VehicleID = clsVehicleData.AddNewVehicle
                (
                    this.MakeID, this.ModelID, this.Year, this.Mileage, this.FuelTypeID, this.PlateNumber,
                    this.CarCategoryID, this.RentalPricePerDay, this.IsAvailableForRent,
                    this.CreatedByUserID, this.ImagePath
                );
            return (this.VehicleID != -1);
        }

        private bool _UpdateVehicle()
        {
            return clsVehicleData.UpdateVehicle
                (
                    this.VehicleID, this.MakeID, this.ModelID, this.Year, this.Mileage, this.FuelTypeID,
                    this.PlateNumber, this.CarCategoryID, this.RentalPricePerDay, this.IsAvailableForRent,
                    this.CreatedByUserID, this.ImagePath
                );
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewVehicle())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateVehicle();
            }
            return false;
        }

        public static bool IsExist(int PlateNumber) => clsVehicleData.IsExist(PlateNumber);

        public static bool DeleteVehicle(int VehicleID) => clsVehicleData.DeleteVehicle(VehicleID);

        public static DataTable GetAllVehicles() => clsVehicleData.GetAllVehicles();

        public static DataTable GetAllVehiclesByMakeName(string MakeName)
        {
            return clsVehicleData.GetAllVehiclesByMakeName(MakeName);
        }
    }
}