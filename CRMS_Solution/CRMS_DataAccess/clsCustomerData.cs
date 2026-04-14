using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsCustomerData
    {
        // Get Customer Info By ID
        public static bool GetCustomerInfoByID
            (   
                int CustomerID, ref string CustomerName, ref string Phone, 
                ref int DriverLicenseNumber, ref int CreatedByUserID
            )
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Customers WHERE CustomerID = @CustomerID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", CustomerID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CustomerName = (string)reader["CustomerName"];
                                Phone = (string)reader["Phone"];
                                DriverLicenseNumber = (int)reader["DriverLicenseNumber"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Customer Info By Name
        public static bool GetCustomerInfoByName
           (
               string CustomerName, ref int CustomerID, ref string Phone,
               ref int DriverLicenseNumber, ref int CreatedByUserID
           )
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Customers WHERE CustomerName = @CustomerName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerName", CustomerName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CustomerID = (int)reader["CustomerID"];
                                Phone = (string)reader["Phone"];
                                DriverLicenseNumber = (int)reader["DriverLicenseNumber"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add Customer
        public static int AddNewCustomer(string CustomerName, string Phone, int DriverLicenseNumber, int CreatedByUserID)
        {
            int CustomerID = -1;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                  INSERT INTO Customers(@CustomerName, Phone, DriverLicenseNumber, CreatedByUserID)
                                  VALUES(@CustomerName, @Phone, @DriverLicenseNumber, @CreatedByUserID);
                                  SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CustomerName", CustomerName);
                    command.Parameters.AddWithValue("@Phone", Phone);
                    command.Parameters.AddWithValue("@DriverLicenseNumber", DriverLicenseNumber);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            CustomerID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        CustomerID = -1;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.StackTrace);
                    }
                }
            }
            return CustomerID;
        }
    

        // Update Customer
        public static bool UpdateCustomer(int CustomerID, string CustomerName, string Phone, int DriverLicenseNumber, int CreatedByUserID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE Customers 
                                    SET CustomerName = @CustomerName,
                                    Phone = @Phone,
                                    DriverLicenseNumber = @DriverLicenseNumber,
                                    CreatedByUserID = @CreatedByUserID
                                    WHERE CustomerID = @CustomerID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CustomerName", CustomerName);
                    command.Parameters.AddWithValue("@Phone", Phone);
                    command.Parameters.AddWithValue("@DriverLicenseNumber", DriverLicenseNumber);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);
                    command.Parameters.AddWithValue("@CustomerID", CustomerID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }
    

        // Delete Customer
        public static bool DeleteCustomer(int CustomerID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM Customers WHERE CustomerID = @CustomerID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", CustomerID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }
       
        // تحقق هل رقم الهاتف يوجد من قبل
        public static bool IsPhoneExist(string Phone)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM Customers WHERE Phone = @Phone;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@Phone", Phone);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        IsExist = (Result != null);
                    }
                    catch (SqlException sqlex)
                    {
                        IsExist = false;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }

        // تحقق هل رخصة القيادة موجودة من قبل
        public static bool IsDriverLicenseExist(int DriverLicense)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM Customers WHERE DriverLicenseNumber = @DriverLicense;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@DriverLicense", DriverLicense);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        IsExist = (Result != null);
                    }
                    catch (SqlException sqlex)
                    {
                        IsExist = false;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }

        // Get All Customers
        public static DataTable GetAllCustomers()
        {
            DataTable dtAllCustomers = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"SELECT CustomerID, CustomerName, Phone, DriverLicenseNumber FROM Customers";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllCustomers = new DataTable();
                                dtAllCustomers.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllCustomers = null;
                        clsEventLogHandler.LogException("DAL - Customers", sqlex.Message);
                    }
                }
            }

            return dtAllCustomers;
        }
    }
}