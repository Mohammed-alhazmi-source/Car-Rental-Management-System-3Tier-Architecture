using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsMake
    {
        public enum enMode { Add = 0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int MakeID {  get; set; }
        public string MakeName { get; set; }

        public clsMake()
        {
            MakeID = -1;
            MakeName = "";
            Mode = enMode.Add;
        }

        private clsMake(int MakeID, string MakeName)
        {
            this.MakeID = MakeID;
            this.MakeName = MakeName;
            Mode = enMode.Update;
        }

        public static clsMake Find(int MakeID)
        {
            string MakeName = "";

            bool IsFind = clsMakeData.GetMakeInfoByID(MakeID, ref MakeName);

            if (IsFind)
                return new clsMake(MakeID, MakeName);

            return null;
        }

        public static clsMake Find(string MakeName)
        {
            int MakeID = -1;

            bool IsFind = clsMakeData.GetMakeInfoByName(MakeName, ref MakeID);

            if (IsFind)
                return new clsMake(MakeID, MakeName);

            return null;
        }

        private bool _AddNewMake()
        {
            this.MakeID = clsMakeData.AddNewMake(this.MakeName);

            return (this.MakeID != -1);
        }

        private bool _UpdateMake() => clsMakeData.UpdateMake(this.MakeID, this.MakeName);

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewMake())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateMake();
            }
            return false;
        }

        public static bool DeleteMake(int MakeID) => clsMakeData.DeleteMake(MakeID);

        public static bool IsExist(string MakeName) => clsMakeData.IsExist(MakeName);

        public static DataTable GetAllMakes() => clsMakeData.GetAllMakes();
    }
}