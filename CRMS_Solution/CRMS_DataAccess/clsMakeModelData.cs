using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsMakeModelData
    {
        // Get Model Info By ID
        public static bool GetMakeModelInfoByID(int ModelID, ref int MakeID, ref string ModelName)
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM MakeModels WHERE ModelID = @ModelID;";

                using(SqlCommand command= new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@ModelID", ModelID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while(reader.Read())
                            {
                                IsFind = true;
                                MakeID = (int)reader["MakeID"];
                                ModelName = (string)reader["ModelName"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Model Info By Name
        public static bool GetMakeModelInfoByName(string ModelName, ref int MakeID, ref int ModelID)
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM MakeModels WHERE ModelName = @ModelName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@ModelName", ModelName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                MakeID = (int)reader["MakeID"];
                                ModelID = (int)reader["ModelID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Model
        public static int AddNewMode(int MakeID, string ModelName)
        {
            int ModelID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"INSERT INTO MakeModels(MakeID, ModelName)
                                 VALUES(@MakeID, @ModelName);
                                 SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@ModelName", ModelName);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            ModelID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        ModelID = -1;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return ModelID;
        }


        // Update Model
        public static bool UpdateModel(int ModelID, int MakeID, string ModelName)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"UPDATE MakeModels 
                                 SET MakeID = @MakeID, ModelName = @ModelName WHERE ModelID = @ModelID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@ModelID", ModelID);
                    command.Parameters.AddWithValue("@ModelName", ModelName);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Model
        public static bool DeleteModel(int ModelID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM MakeModels WHERE ModelID = @ModelID";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@ModelID", ModelID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Is Model Exist
        public static bool IsExist(string ModeName)
        {
            bool IsExisting = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT TOP 1 Found = 1 FROM MakeModels WHERE ModelName = @ModelName;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@ModelName", ModeName);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int Value))
                            IsExisting = true;
                    }
                    catch (SqlException sqlex)
                    {
                        IsExisting = false;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return IsExisting;
        }

        
        // Get All Models
        public static DataTable GetAllMakeModels()
        {
            DataTable dtAllMakeModels = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM MakeModels_View;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllMakeModels = new DataTable();
                                dtAllMakeModels.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllMakeModels = null;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return dtAllMakeModels;
        }

        public static DataTable GetAllModelsByMakeID(int MakeID)
        {
            DataTable dtAllMakeModels = null;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM MakeModels WHERE MakeID = @MakeID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                dtAllMakeModels = new DataTable();
                                dtAllMakeModels.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllMakeModels = null;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return dtAllMakeModels;
        }

        public static DataTable GetAllModelsByMakeName(string MakeName)
        {
            DataTable dtAllMakeModels = null;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    SELECT MM.*
                                    FROM MakeModels MM
                                    JOIN Makes M
                                    ON MM.MakeID = M.MakeID
                                    WHERE M.MakeName = @MakeName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@MakeName", MakeName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                dtAllMakeModels = new DataTable();
                                dtAllMakeModels.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllMakeModels = null;
                        clsEventLogHandler.LogException("DAL - MakeModels", sqlex.Message);
                    }
                }
            }

            return dtAllMakeModels;
        }
    }
}