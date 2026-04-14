using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsCustomer
    {
        public enum enMode { Add =  0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string Phone { get; set; }
        public int DriverLicenseNumber { get; set; }
        public int CreatedByUserID { get; set; }

        public clsUser UserInfo { get; set; }

        public clsCustomer()
        {
            CustomerID = -1;
            CustomerName = string.Empty;
            Phone = string.Empty;
            DriverLicenseNumber = -1;
            CreatedByUserID = -1;
            Mode = enMode.Add;
        }

        private clsCustomer(int CustomerID, string CustomerName, string Phone, int DriverLicenseNumber, int CreatedByUserID)
        {
            this.CustomerID = CustomerID;
            this.CustomerName = CustomerName;
            this.Phone = Phone;
            this.DriverLicenseNumber = DriverLicenseNumber;
            this.CreatedByUserID = CreatedByUserID;
            UserInfo = clsUser.FindByUserID(this.CreatedByUserID);
            Mode = enMode.Update;
        }

        public static clsCustomer Find(int CustomerID)
        {
            string CustomerName = "", Phone = "";
            int DriverLicenseNumber = -1, CreatedByUserID = -1;

            bool IsFind = clsCustomerData.GetCustomerInfoByID
                (
                    CustomerID, ref CustomerName, ref Phone, ref DriverLicenseNumber, ref CreatedByUserID
                );

            if (IsFind)
                return new clsCustomer(CustomerID, CustomerName, Phone, DriverLicenseNumber, CreatedByUserID);

            return null;
        }

        public static clsCustomer Find(string CustomerName)
        {
            int CustomerID = -1, DriverLicenseNumber = -1, CreatedByUserID = -1;
            string Phone = "";

            bool IsFind = clsCustomerData.GetCustomerInfoByName
                (
                    CustomerName,ref CustomerID, ref Phone, ref DriverLicenseNumber, ref CreatedByUserID
                );

            if (IsFind)
                return new clsCustomer(CustomerID, CustomerName, Phone, DriverLicenseNumber, CreatedByUserID);

            return null;
        }

        private bool _AddNewCustomer()
        {
            this.CustomerID = clsCustomerData.AddNewCustomer(this.CustomerName, this.Phone, this.DriverLicenseNumber, this.CreatedByUserID);

            return (this.CustomerID != -1);
        }

        private bool _UpdateCustomer()
        {
            return clsCustomerData.UpdateCustomer(this.CustomerID, this.CustomerName, this.Phone, this.DriverLicenseNumber, this.CreatedByUserID);
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewCustomer())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateCustomer();
            }
            return false;
        }

        public static bool DeleteCustomer(int CustomerID) => clsCustomerData.DeleteCustomer(CustomerID);
      
        public static bool IsDriverLicenseExist(int DriverLicenseNumber) => clsCustomerData.IsDriverLicenseExist(DriverLicenseNumber);

        public static bool IsExist(string Phone) => clsCustomerData.IsPhoneExist(Phone);

        public static DataTable GetAllCustomers() => clsCustomerData.GetAllCustomers();
    }
}