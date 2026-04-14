using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsVehicleReturnData
    {
        // Get Vehicle Return Info By ID
        public static bool GetVehicleReturnInfoByID
            (
                int ReturnID, ref DateTime ActualReturnDate, ref int ActualRentalDays, ref int Mileage,
                ref int ConsumedMileage, ref string FinalCheckNotes, ref decimal AdditionalCharges,
                ref decimal ActualTotalDueAmount, ref int CreatedByUserID
            )
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM VehicleReturns WHERE ReturnID = @ReturnID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@ReturnID", ReturnID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                ActualReturnDate = (DateTime)reader["ActualReturnDate"];
                                ActualRentalDays = (int)reader["ActualRentalDays"];
                                Mileage = (int)reader["Mileage"];
                                ConsumedMileage = (int)reader["ConsumedMileage"];
                                FinalCheckNotes = (string)reader["FinalCheckNotes"];
                                AdditionalCharges = (decimal)reader["AdditionalCharges"];
                                ActualTotalDueAmount = (decimal)reader["ActualTotalDueAmount"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - VehicleReturns", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Vehicle Return
        public static int AddNewVehicleReturn
            (
                int BookingID, int VehicleID, DateTime ActualReturnDate, int ActualRentalDays, int Mileage,
                int ConsumedMileage, string FinalCheckNotes, decimal AdditionalCharges,
                decimal ActualTotalDueAmount, int CreatedByUserID
            )
        {
            int ReturnID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE Vehicles SET IsAvailableForRent = 1, Mileage = @Mileage 
                                    WHERE VehicleID = @VehicleID
                            
                                    UPDATE RentalBooking SET IsBooking = 0 
                                    WHERE BookingID = @BookingID AND VehicleID = @VehicleID;

                                    INSERT INTO VehicleReturns
                                               (
                                    			 ActualReturnDate ,ActualRentalDays ,Mileage,
                                    			 ConsumedMileage  ,FinalCheckNotes ,AdditionalCharges,
                                    			 ActualTotalDueAmount,CreatedByUserID
                                    		   )
                                         VALUES
                                               (
                                    			 @ActualReturnDate, @ActualRentalDays, @Mileage, 
                                    			 @ConsumedMileage, @FinalCheckNotes, @AdditionalCharges,
                                    			 @ActualTotalDueAmount, @CreatedByUserID
                                    		   );
                                    SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query, connection))
                {

                    command.Parameters.AddWithValue("@BookingID", BookingID);
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);
                    command.Parameters.AddWithValue("@ActualReturnDate", ActualReturnDate);
                    command.Parameters.AddWithValue("@ActualRentalDays", ActualRentalDays);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@ConsumedMileage", ConsumedMileage);
                    command.Parameters.AddWithValue("@FinalCheckNotes", FinalCheckNotes);
                    command.Parameters.AddWithValue("@AdditionalCharges", AdditionalCharges);
                    command.Parameters.AddWithValue("@ActualTotalDueAmount", ActualTotalDueAmount);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            ReturnID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        ReturnID = -1;
                        clsEventLogHandler.LogException("DAL - VehicleReturns", sqlex.Message);
                    }
                }
            }

            return ReturnID;
        }


        // Update Vehicle Return
        public static bool UpdateVehicleReturn
            (
                int ReturnID, DateTime ActualReturnDate, int ActualRentalDays, int Mileage,
                int ConsumedMileage, string FinalCheckNotes, decimal AdditionalCharges,
                decimal ActualTotalDueAmount, int CreatedByUserID
            )
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE VehicleReturns
                                       SET ActualReturnDate = @ActualReturnDate,
                                    	   ActualRentalDays = @ActualRentalDays,
                                    	   Mileage = @Mileage,
                                    	   ConsumedMileage = @ConsumedMileage,
                                    	   FinalCheckNotes = @FinalCheckNotes,
                                    	   AdditionalCharges = @AdditionalCharges,
                                    	   ActualTotalDueAmount = @ActualTotalDueAmount,
                                    	   CreatedByUserID = @CreatedByUserID 
                                     WHERE ReturnID = @ReturnID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@ReturnID", ReturnID);
                    command.Parameters.AddWithValue("@ActualReturnDate", ActualReturnDate);
                    command.Parameters.AddWithValue("@ActualRentalDays", ActualRentalDays);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@ConsumedMileage", ConsumedMileage);
                    command.Parameters.AddWithValue("@FinalCheckNotes", FinalCheckNotes);
                    command.Parameters.AddWithValue("@AdditionalCharges", AdditionalCharges);
                    command.Parameters.AddWithValue("@ActualTotalDueAmount", ActualTotalDueAmount);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - VehicleReturns", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Vehicle Return
        public static bool DeleteVehicleReturn(int ReturnID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM VehicleReturns WHERE ReturnID = @ReturnID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@ReturnID", ReturnID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - VehicleReturns", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Get All Vehicle Return
        public static DataTable GetAllVehiclesReturn()
        {
            DataTable dtAllVehicles = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM VehiclesReturn_View;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllVehicles = new DataTable();
                                dtAllVehicles.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllVehicles = null;
                        clsEventLogHandler.LogException("DAL - VehicleReturns", sqlex.Message);
                    }
                }
            }

            return dtAllVehicles;
        }
    }
}