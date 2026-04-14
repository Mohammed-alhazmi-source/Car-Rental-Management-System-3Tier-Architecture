using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsFuelType
    {
        public enum enMode { Add = 0, Update = 1};
        public enMode Mode = enMode.Add;

        public int FuelTypeID {  get; set; }
        public string FuelType { get; set; }

        public clsFuelType()
        {
            FuelTypeID = -1;
            FuelType = "";
            Mode = enMode.Add;
        }

        private clsFuelType(int FuelTypeID, string FuelType)
        {
            this.FuelTypeID = FuelTypeID;
            this.FuelType = FuelType;
            Mode = enMode.Update;
        }

        public static clsFuelType Find(int FuelTypeID)
        {
            string FuelType = "";

            bool IsFind = clsFuelTypeData.GetFuelTypeInfoByID(FuelTypeID, ref FuelType);

            if (IsFind)
                return new clsFuelType(FuelTypeID, FuelType);

            return null;
        }

        public static clsFuelType Find(string FuelType)
        {
            int FuelTypeID = -1;

            bool IsFind = clsFuelTypeData.GetFuelTypeInfoByName(FuelType, ref FuelTypeID);

            if (IsFind)
                return new clsFuelType(FuelTypeID, FuelType);

            return null;
        }

        private bool _AddNewFuelType()
        {
            this.FuelTypeID = clsFuelTypeData.AddNewFuelType(this.FuelType);
            return (this.FuelTypeID != -1);
        }

        private bool _UpdateFuelType() => clsFuelTypeData.UpdateFuelType(this.FuelTypeID, this.FuelType);

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewFuelType())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateFuelType();
            }
            return false;
        }

        public static bool DeleteFuelType(int FuelTypeID) => clsFuelTypeData.DeleteFuelType(FuelTypeID);

        public static bool IsExist(string FuelType) => clsFuelTypeData.IsExist(FuelType);

        public static DataTable GetAllFuelTypes() => clsFuelTypeData.GetAllFuelTypes();
    }
}