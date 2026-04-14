using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace CRMS_DataAccess
{
    public class clsRentalBookingData
    {
        // Get Rental Booking Info By ID
        public static bool GetRentalBookingInfoByID
            (
                int BookingID, ref int CustomerID, ref int VehicleID, ref DateTime RentalStartDate,
                ref DateTime RentalEndDate, ref string PickupLocation, ref string DropOfLocation,
                ref int InitialRentalDays, ref decimal RentalPricePerDay, ref decimal InitialTotalDueAmount,
                ref string InitialCheckNotes, ref int CreatedByUserID
            )
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM RentalBooking WHERE BookingID = @BookingID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CustomerID = (int)reader["CustomerID"];
                                VehicleID = (int)reader["VehicleID"];
                                RentalStartDate = (DateTime)reader["RentalStartDate"];
                                RentalEndDate = (DateTime)reader["RentalEndDate"];
                                PickupLocation = (string)reader["PickupLocation"];
                                DropOfLocation = (string)reader["DropOfLocation"];
                                InitialRentalDays = (int)reader["InitialRentalDays"];
                                RentalPricePerDay = (decimal)reader["RentalPricePerDay"];
                                InitialTotalDueAmount = (decimal)reader["InitialTotalDueAmount"];
                                InitialCheckNotes = (string)reader["InitialCheckNotes"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Rental Booking Info By Vehicle ID
        public static bool GetRentalBookingInfoByVehicleID
            (
                int VehicleID, ref int BookingID, ref int CustomerID, ref DateTime RentalStartDate,
                ref DateTime RentalEndDate, ref string PickupLocation, ref string DropOfLocation,
                ref int InitialRentalDays, ref decimal RentalPricePerDay, ref decimal InitialTotalDueAmount,
                ref string InitialCheckNotes, ref int CreatedByUserID
            )
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                //string Query = "SELECT * FROM RentalBooking WHERE VehicleID = @VehicleID;";

                string Query = @"
                                  SELECT RB.* FROM RentalBooking RB
                                  JOIN Vehicles V
                                  ON RB.VehicleID = V.VehicleID
                                  WHERE RB.IsBooking = 1 AND RB.VehicleID = @VehicleID";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                CustomerID = (int)reader["CustomerID"];
                                BookingID = (int)reader["BookingID"];
                                RentalStartDate = (DateTime)reader["RentalStartDate"];
                                RentalEndDate = (DateTime)reader["RentalEndDate"];
                                PickupLocation = (string)reader["PickupLocation"];
                                DropOfLocation = (string)reader["DropOfLocation"];
                                InitialRentalDays = (int)reader["InitialRentalDays"];
                                RentalPricePerDay = (decimal)reader["RentalPricePerDay"];
                                InitialTotalDueAmount = (decimal)reader["InitialTotalDueAmount"];
                                InitialCheckNotes = (string)reader["InitialCheckNotes"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Booking
        public static int AddNewBooking
            (
                int CustomerID, int VehicleID, DateTime RentalStartDate, DateTime RentalEndDate,
                string PickupLocation, string DropOfLocation, int InitialRentalDays,
                decimal RentalPricePerDay, decimal InitialTotalDueAmount, string InitialCheckNotes, int CreatedByUserID
            )
        {
            int BookingID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                  UPDATE Vehicles SET IsAvailableForRent = 0 WHERE VehicleID = @VehicleID;

                                  INSERT INTO RentalBooking
                                             (
                                  			    CustomerID,VehicleID,RentalStartDate,
                                  			    RentalEndDate,PickupLocation,DropOfLocation,
                                  			    InitialRentalDays,RentalPricePerDay,InitialTotalDueAmount,
                                                InitialCheckNotes,CreatedByUserID
                                  			 )
                                  VALUES
                                             (
                                  			   @CustomerID,@VehicleID,@RentalStartDate, 
                                               @RentalEndDate,@PickupLocation,@DropOfLocation,
                                               @InitialRentalDays,@RentalPricePerDay,@InitialTotalDueAmount, 
                                               @InitialCheckNotes, @CreatedByUserID
                                  			 );
                                  SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@CustomerID", CustomerID);
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);
                    command.Parameters.AddWithValue("@RentalStartDate", RentalStartDate);
                    command.Parameters.AddWithValue("@RentalEndDate", RentalEndDate);
                    command.Parameters.AddWithValue("@PickupLocation", PickupLocation);
                    command.Parameters.AddWithValue("@DropOfLocation", DropOfLocation);
                    command.Parameters.AddWithValue("@InitialRentalDays", InitialRentalDays);
                    command.Parameters.AddWithValue("@RentalPricePerDay", RentalPricePerDay);
                    command.Parameters.AddWithValue("@InitialTotalDueAmount", InitialTotalDueAmount);
                    command.Parameters.AddWithValue("@InitialCheckNotes", InitialCheckNotes);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            BookingID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        BookingID = -1;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return BookingID;
        }


        // Update Booking
        public static bool UpdateBooking
            (
                int BookingID,int CustomerID, int VehicleID, DateTime RentalStartDate, DateTime RentalEndDate,
                string PickupLocation, string DropOfLocation, int InitialRentalDays,
                decimal RentalPricePerDay, decimal InitialTotalDueAmount, string InitialCheckNotes, int CreatedByUserID
            )
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE RentalBooking
                                       SET CustomerID = @CustomerID, 
                                           VehicleID = @VehicleID,
                                           RentalStartDate = @RentalStartDate,
                                           RentalEndDate = @RentalEndDate,
                                           PickupLocation = @PickupLocation,
                                           DropOfLocation = @DropOfLocation,
                                           InitialRentalDays = @InitialRentalDays,
                                           RentalPricePerDay = @RentalPricePerDay,
                                           InitialTotalDueAmount = @InitialTotalDueAmount,
                                           InitialCheckNotes = @InitialCheckNotes,
                                           CreatedByUserID = @CreatedByUserID
                                     WHERE BookingID = @BookingID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);
                    command.Parameters.AddWithValue("@CustomerID", CustomerID);
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);
                    command.Parameters.AddWithValue("@RentalStartDate", RentalStartDate);
                    command.Parameters.AddWithValue("@RentalEndDate", RentalEndDate);
                    command.Parameters.AddWithValue("@PickupLocation", PickupLocation);
                    command.Parameters.AddWithValue("@DropOfLocation", DropOfLocation);
                    command.Parameters.AddWithValue("@InitialRentalDays", InitialRentalDays);
                    command.Parameters.AddWithValue("@RentalPricePerDay", RentalPricePerDay);
                    command.Parameters.AddWithValue("@InitialTotalDueAmount", InitialTotalDueAmount);
                    command.Parameters.AddWithValue("@InitialCheckNotes", InitialCheckNotes);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Booking
        public static bool DeleteBooking(int BookingID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM RentalBooking WHERE BookingID = @BookingID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }

        // Get All Rentals Booking
        public static DataTable GetAllRentalsBooking()
        {
            DataTable dtAllRentalsBooking = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM RentalBooking_View;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllRentalsBooking = new DataTable();
                                dtAllRentalsBooking.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllRentalsBooking = null;
                        clsEventLogHandler.LogException("DAL - RentalBooking", sqlex.Message);
                    }
                }
            }

            return dtAllRentalsBooking;
        }
    }
}