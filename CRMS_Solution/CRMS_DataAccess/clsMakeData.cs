using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsMakeData
    {
        // Get Make Info By ID
        public static bool GetMakeInfoByID(int MakeID, ref string MakeName)
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Makes WHERE MakeID = @MakeID;";

                using(SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                MakeName = (string)reader["MakeName"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Make Info By Name
        public static bool GetMakeInfoByName(string MakeName, ref int MakeID)
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT TOP 1 * FROM Makes WHERE MakeName = @MakeName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@MakeName", MakeName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                MakeID = (int)reader["MakeID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Make
        public static int AddNewMake(string MakeName)
        {
            int MakeID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @" INSERT INTO Makes(MakeName) VALUES(@MakeName);
                                  SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeName", MakeName);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            MakeID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        MakeID = -1;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return MakeID;
        }


        // Update Make
        public static bool UpdateMake(int MakeID, string MakeName)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "UPDATE Makes SET MakeName = @MakeName WHERE MakeID = @MakeID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@MakeName", MakeName);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Make
        public static bool DeleteMake(int MakeID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM Makes WHERE MakeID = @MakeID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Is Make Exist
        public static bool IsExist(string MakeName)
        {
            bool IsExisting = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM Makes WHERE MakeName = @MakeName;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeName", MakeName);

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
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return IsExisting;
        }


        // Get All Makes
        public static DataTable GetAllMakes()
        {
            DataTable dtAllMakes = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Makes;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader = command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllMakes = new DataTable();
                                dtAllMakes.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllMakes = null;
                        clsEventLogHandler.LogException("DAL - Makes", sqlex.Message);
                    }
                }
            }

            return dtAllMakes;
        }
    }
}