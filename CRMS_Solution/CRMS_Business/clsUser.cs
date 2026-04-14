using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsUser
    {
        public enum enMode { Add = 0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int UserID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool IsActive { get; set; }
        public int PersonID { get; set; }

        public clsPerson PersonInfo { get; set; }

        public clsUser()
        {
            UserID = -1;
            UserName = "";
            Password = "";
            IsActive = true;
            PersonID = -1;
            Mode = enMode.Add;
        }

        private clsUser(int UserID, string UserName, string Password, bool IsActive, int PersonID)
        {
            this.UserID = UserID;
            this.UserName = UserName;
            this.Password = Password;
            this.IsActive = IsActive;
            this.PersonID = PersonID;
            this.PersonInfo = clsPerson.Find(this.PersonID);
            Mode = enMode.Update;
        }

        public static clsUser FindByUserID(int UserID)
        {
            string UserName = "", Password = "";
            bool IsActive = false;
            int PersonID = -1;

            bool IsFind = clsUserData.GetUserInfoByID(UserID, ref UserName, ref Password, ref IsActive, ref PersonID);

            if (IsFind)
                return new clsUser(UserID, UserName, Password, IsActive, PersonID);

            return null;
        }

        public static clsUser FindByPersonID(int PersonID)
        {
            string UserName = "", Password = "";
            bool IsActive = false;
            int UserID = -1;

            bool IsFind = clsUserData.GetUserInfoByPersonID(PersonID, ref UserName, ref Password, ref IsActive, ref UserID);

            if (IsFind)
                return new clsUser(UserID, UserName, Password, IsActive, PersonID);

            return null;
        }

        private bool _AddNewUser()
        {
            this.UserID = clsUserData.AddNewUser(this.PersonID, this.UserName, this.Password, this.IsActive);
            return (this.UserID != -1);
        }

        private bool _UpdateUser()
        {
            return clsUserData.UpdateUser(this.UserID, this.UserName, this.Password, this.IsActive, this.PersonID);
        }

        public static bool DeleteUser(int UserID)
        {
            return clsUserData.DeleteUser(UserID);
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewUser())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateUser();
            }

            return false;
        }

        public static bool IsExist(int PersonID)
        {
            return clsUserData.IsExist(PersonID);
        }

        public static bool IsExist(string UserName)
        {
            return clsUserData.IsExist(UserName);
        }

        public static clsUser IsExist(string UserName, string Password)
        {
            int UserID = -1, PersonID = -1;
            bool IsActive = false;

            bool IsFound = clsUserData.IsExist(UserName, Password, ref UserID, ref PersonID, ref IsActive);

            if (IsFound)
                return new clsUser(UserID, UserName, Password, IsActive, PersonID);

            return null;
        }
        public bool IsPersonExist()
        {
            return IsExist(this.PersonID);
        }

        public bool IsUserNameExist()
        {
            return IsExist(this.UserName);
        }

        public static DataTable GetAllUsers()
        {
            return clsUserData.GetAllUsers();
        }
    }
}