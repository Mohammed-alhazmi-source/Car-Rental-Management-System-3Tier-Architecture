using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsVehicleCategoryData
    {
        // Get Car Category Info By ID
        public static bool GetCarCategoryInfoByID(int CategoryID, ref string CategoryName)
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM VehicleCategories WHERE CategoryID = @CategoryID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryID", CategoryID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CategoryName = (string)reader["CategoryName"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }
            return IsFind;
        }


        // Get Car Category Info By Name
        public static bool GetCarCategoryInfoByName(string CategoryName, ref int CategoryID)
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM VehicleCategories WHERE CategoryName = @CategoryName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryName", CategoryName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CategoryID = (int)reader["CategoryID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }
            return IsFind;
        }


        // Add New Category
        public static int AddNewCategory(string CategoryName)
        {
            int CategoryID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"INSERT INTO VehicleCategories(CategoryName) 
                                 VALUES(@CategoryName);
                                 SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CategoryName", CategoryName);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            CategoryID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        CategoryID = -1;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }

            return CategoryID;
        }


        // Update Category
        public static bool UpdateCategory(int CategoryID, string CategoryName)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "UPDATE VehicleCategories SET CategoryName = @CategoryName WHERE CategoryID = @CategoryID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CategoryID", CategoryID);
                    command.Parameters.AddWithValue("@CategoryName", CategoryName);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Category
        public static bool DeleteCategory(int CategoryID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM VehicleCategories WHERE CategoryID = @CategoryID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CategoryID", CategoryID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Is Category Exist
        public static bool IsExist(string CategoryName)
        {
            bool IsExisting = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM VehicleCategories WHERE CategoryName = @CategoryName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@CategoryName", CategoryName);

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
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }

            return IsExisting;
        }


        // Get All Vehicle Categories
        public static DataTable GetAllVehicleCategories()
        {
            DataTable dtAllVehicleCategories = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM VehicleCategories;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllVehicleCategories = new DataTable();
                                dtAllVehicleCategories.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllVehicleCategories = null;
                        clsEventLogHandler.LogException("DAL - VehicleCategories", sqlex.Message);
                    }
                }
            }

            return dtAllVehicleCategories;
        }
    }
}