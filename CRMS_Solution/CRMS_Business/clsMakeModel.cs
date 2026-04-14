using CRMS_DataAccess;
using System.Data;

namespace CRMS_Business
{
    public class clsMakeModel
    {
        public enum enMode { Add =  0, Update = 1 };
        public enMode Mode = enMode.Add;

        public int ModelID { get; set; }
        public int MakeID { get; set; }
        public string ModelName { get; set; }

        public clsMake MakeInfo { get; set; }

        public clsMakeModel()
        {
            ModelID = -1;
            MakeID = -1;
            ModelName = "";
            Mode = enMode.Add;
        }

        private clsMakeModel(int ModelID, int MakeID, string ModelName)
        {
            this.ModelID = ModelID;
            this.MakeID = MakeID;
            this.ModelName = ModelName;
            MakeInfo = clsMake.Find(this.MakeID);
            Mode = enMode.Update;
        }

        public static clsMakeModel Find(int ModelID)
        {
            int MakeID = -1;
            string ModelName = "";

            bool IsFind = clsMakeModelData.GetMakeModelInfoByID(ModelID, ref MakeID, ref ModelName);

            if (IsFind)
                return new clsMakeModel(ModelID, MakeID, ModelName);

            return null;
        }

        public static clsMakeModel Find(string ModelName)
        {
            int MakeID = -1, ModelID = -1;
            
            bool IsFind = clsMakeModelData.GetMakeModelInfoByName(ModelName, ref MakeID, ref ModelID);

            if (IsFind)
                return new clsMakeModel(ModelID, MakeID, ModelName);

            return null;
        }

        private bool _AddNewModel()
        {
            this.ModelID = clsMakeModelData.AddNewMode(this.MakeID, this.ModelName);
            return (this.ModelID != -1);
        }

        private bool _UpdateModel()
        {
            return clsMakeModelData.UpdateModel(this.ModelID, this.MakeID, this.ModelName);
        }

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewModel())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdateModel();
            }

            return false;
        }

        public static bool DeleteModel(int ModelID) => clsMakeModelData.DeleteModel(ModelID);

        public static bool IsExist(string ModelName) => clsMakeModelData.IsExist(ModelName);

        public static DataTable GetAllMakeModels() => clsMakeModelData.GetAllMakeModels();

        public static DataTable GetAllModelsByMakeID(int MakeID) => clsMakeModelData.GetAllModelsByMakeID(MakeID);

        public static DataTable GetAllModelsByMakeName(string MakeName)
        {
            return clsMakeModelData.GetAllModelsByMakeName(MakeName);
        }
    }
}