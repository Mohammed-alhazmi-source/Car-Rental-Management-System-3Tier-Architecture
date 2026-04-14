using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsVehicleCategory
    {
        public enum enMode { Add = 0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int CategoryID {  get; set; }    
        public string CategoryName { get; set; }

        public clsVehicleCategory()
        {
            CategoryID = -1;
            CategoryName = "";
            Mode = enMode.Add;
        }

        private clsVehicleCategory(int CategoryID, string CategoryName)
        {
            this.CategoryID = CategoryID;
            this.CategoryName = CategoryName;
            Mode = enMode.Update;
        }

        public static clsVehicleCategory Find(int CategoryID)
        {
            string CategoryName = "";

            bool IsFind = clsVehicleCategoryData.GetCarCategoryInfoByID(CategoryID, ref CategoryName);

            if (IsFind)
                return new clsVehicleCategory(CategoryID, CategoryName);

            return null;
        }

        public static clsVehicleCategory Find(string CategoryName)
        {
            int CategoryID = -1;

            bool IsFind = clsVehicleCategoryData.GetCarCategoryInfoByName(CategoryName, ref CategoryID);

            if (IsFind)
                return new clsVehicleCategory(CategoryID, CategoryName);

            return null;
        }

        private bool _AddNewCategory()
        {
            this.CategoryID = clsVehicleCategoryData.AddNewCategory(this.CategoryName);
            return (this.CategoryID != -1);
        }

        private bool _UpdateCategory()
        {
            return clsVehicleCategoryData.UpdateCategory(this.CategoryID, this.CategoryName);
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewCategory())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateCategory();
            }

            return false;
        }

        public static bool DeleteCategory(int CategoryID) => clsVehicleCategoryData.DeleteCategory(CategoryID);

        public static bool IsExist(string CategoryName) => clsVehicleCategoryData.IsExist(CategoryName);

        public static DataTable GetAllVehicleCategories() => clsVehicleCategoryData.GetAllVehicleCategories();
    }
}