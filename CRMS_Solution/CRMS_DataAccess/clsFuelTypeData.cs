using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsFuelTypeData
    {
        // Get Fuel Type Info By ID
        public static bool GetFuelTypeInfoByID(int FuelTypeID, ref string FuelType)
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM FuelTypes WHERE FuelTypeID = @FuelTypeID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@FuelTypeID", FuelTypeID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                FuelType = (string)reader["FuelType"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Fuel Type Info By Name
        public static bool GetFuelTypeInfoByName(string FuelType, ref int FuelTypeID)
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM FuelTypes WHERE FuelType = @FuelType;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@FuelType", FuelType);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                FuelTypeID = (int)reader["FuelTypeID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Fuel Type
        public static int AddNewFuelType(string FuelType)
        {
            int FuelTypeID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "INSERT INTO FuelTypes(FuelType) VALUES(@FuelType); SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@FuelType", FuelType);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            FuelTypeID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        FuelTypeID = -1;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return FuelTypeID;
        }


        // Update Fuel Type
        public static bool UpdateFuelType(int FuelTypeID, string FuelType)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "UPDATE FuelTypes SET FuelType = @FuelType WHERE FuelTypeID = @FuelTypeID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@FuelTypeID", FuelTypeID);
                    command.Parameters.AddWithValue("@FuelType", FuelType);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Fuel Type
        public static bool DeleteFuelType(int FuelTypeID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM FuelTypes WHERE FuelTypeID = @FuelTypeID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@FuelTypeID", FuelTypeID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Is Exist Fuel Type
        public static bool IsExist(string FuelType)
        {
            bool IsExisting = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT TOP 1 Found = 1 FROM FuelTypes WHERE FuelType = @FuelType;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@FuelType", FuelType);

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
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return IsExisting;
        }


        // Get All Fuel Types
        public static DataTable GetAllFuelTypes()
        {
            DataTable dtAllFuelTypes = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM FuelTypes;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllFuelTypes = new DataTable();
                                dtAllFuelTypes.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllFuelTypes = null;
                        clsEventLogHandler.LogException("DAL - FuelTypes", sqlex.Message);
                    }
                }
            }

            return dtAllFuelTypes;
        }
    }
}