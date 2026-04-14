using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsRentalTransactionData
    {
        // Get Rental Transaction Info By ID
        public static bool GetRentalTransactionInfoByID
            (
                int TransactionID, ref int BookingID, ref int? ReturnID, ref string PaymentDetails,
                ref decimal PaidInitialTotalDueAmount, ref decimal? ActualTotalDueAmount,
                ref decimal? TotalRemaining, ref decimal? TotalRefundedAmount, ref DateTime TransactionDate,
                ref int CreatedByUserID, ref DateTime? UpdatedTransactionDate, ref int? UpdatedByUserID
            )
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM RentalTransaction WHERE TransactionID = @TransactionID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@TransactionID", TransactionID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while(reader.Read())
                            {
                                IsFind = true;
                                BookingID = (int)reader["BookingID"];
                                PaymentDetails = (string)reader["PaymentDetails"];
                                PaidInitialTotalDueAmount = (decimal)reader["PaidInitialTotalDueAmount"];
                                TransactionDate = (DateTime)reader["TransactionDate"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];


                                if (reader["ReturnID"] == DBNull.Value)
                                    ReturnID = null;
                                else
                                    ReturnID = (int)reader["ReturnID"];


                                if (reader["ActualTotalDueAmount"] == DBNull.Value)
                                    ActualTotalDueAmount = null;
                                else
                                    ActualTotalDueAmount = (decimal)reader["ActualTotalDueAmount"];


                                if (reader["TotalRemaining"] == DBNull.Value)
                                    TotalRemaining = null;
                                else
                                    TotalRemaining = (decimal)reader["TotalRemaining"];


                                if (reader["TotalRefundedAmount"] == DBNull.Value)
                                    TotalRefundedAmount = null;
                                else
                                    TotalRefundedAmount = (decimal)reader["TotalRefundedAmount"];


                                if (reader["UpdatedTransactionDate"] == DBNull.Value)
                                    UpdatedTransactionDate = null;
                                else
                                    UpdatedTransactionDate = (DateTime)reader["UpdatedTransactionDate"];


                                if (reader["UpdatedByUserID"] == DBNull.Value)
                                    UpdatedByUserID = null;
                                else
                                    UpdatedByUserID = (int)reader["UpdatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Rental Transaction Info By BookingID
        public static bool GetRentalTransactionInfoByBookingID
            (
                int BookingID, ref int TransactionID, ref int? ReturnID, ref string PaymentDetails,
                ref decimal PaidInitialTotalDueAmount, ref decimal? ActualTotalDueAmount,
                ref decimal? TotalRemaining, ref decimal? TotalRefundedAmount, ref DateTime TransactionDate,
                ref int CreatedByUserID, ref DateTime? UpdatedTransactionDate, ref int? UpdatedByUserID
            )
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM RentalTransaction WHERE BookingID = @BookingID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                TransactionID = (int)reader["TransactionID"];
                                PaymentDetails = (string)reader["PaymentDetails"];
                                PaidInitialTotalDueAmount = (decimal)reader["PaidInitialTotalDueAmount"];
                                TransactionDate = (DateTime)reader["TransactionDate"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];


                                if (reader["ReturnID"] == DBNull.Value)
                                    ReturnID = null;
                                else
                                    ReturnID = (int)reader["ReturnID"];


                                if (reader["ActualTotalDueAmount"] == DBNull.Value)
                                    ActualTotalDueAmount = null;
                                else
                                    ActualTotalDueAmount = (decimal)reader["ActualTotalDueAmount"];


                                if (reader["TotalRemaining"] == DBNull.Value)
                                    TotalRemaining = null;
                                else
                                    TotalRemaining = (decimal)reader["TotalRemaining"];


                                if (reader["TotalRefundedAmount"] == DBNull.Value)
                                    TotalRefundedAmount = null;
                                else
                                    TotalRefundedAmount = (decimal)reader["TotalRefundedAmount"];


                                if (reader["UpdatedTransactionDate"] == DBNull.Value)
                                    UpdatedTransactionDate = null;
                                else
                                    UpdatedTransactionDate = (DateTime)reader["UpdatedTransactionDate"];


                                if (reader["UpdatedByUserID"] == DBNull.Value)
                                    UpdatedByUserID = null;
                                else
                                    UpdatedByUserID = (int)reader["UpdatedByUserID"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Add New Rental Transaction
        public static int AddNewRentalTransaction
            (
                int BookingID, string PaymentDetails, 
                decimal PaidInitialTotalDueAmount, DateTime TransactionDate, int CreatedByUserID
            )
        {
            int TransactionID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    INSERT INTO RentalTransaction
                                               (
                                                 BookingID,PaymentDetails,PaidInitialTotalDueAmount, 
                                                 TransactionDate,CreatedByUserID
                                               )
                                         VALUES
                                               (
                                                 @BookingID,@PaymentDetails,@PaidInitialTotalDueAmount,
                                                 @TransactionDate,@CreatedByUserID
                                               );
                                    SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);
                    command.Parameters.AddWithValue("@PaymentDetails", PaymentDetails);
                    command.Parameters.AddWithValue("@PaidInitialTotalDueAmount", PaidInitialTotalDueAmount);
                    command.Parameters.AddWithValue("@TransactionDate", TransactionDate);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            TransactionID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        TransactionID = -1;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return TransactionID;
        }


        // Update Rental Transaction Before Vehicle Return
        public static bool UpdateRentalTransaction
            (
                int TransactionID, int BookingID, string PaymentDetails, decimal PaidInitialTotalDueAmount
            )
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE RentalTransaction
                                       SET BookingID = @BookingID,            
                                           PaymentDetails = @PaymentDetails,
                                           PaidInitialTotalDueAmount = @PaidInitialTotalDueAmount
                                     WHERE TransactionID = @TransactionID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@TransactionID", TransactionID);
                    command.Parameters.AddWithValue("@BookingID", BookingID);
                    command.Parameters.AddWithValue("@PaymentDetails", PaymentDetails);
                    command.Parameters.AddWithValue("@PaidInitialTotalDueAmount", PaidInitialTotalDueAmount);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Update Rental Transaction After Vehicle Return
        public static bool UpdateRentalTransactionAfterVehicleReturn
            (
                int TransactionID, int? ReturnID, decimal? ActualTotalDueAmount, decimal? TotalRemaining,
                decimal? TotalRefundedAmount, DateTime? UpdatedTransactionDate, int? UpdatedByUserID
            )
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    UPDATE RentalTransaction
                                       SET ReturnID = @ReturnID,            
                                           ActualTotalDueAmount = @ActualTotalDueAmount,
                                           TotalRemaining = @TotalRemaining,
                                           TotalRefundedAmount = @TotalRefundedAmount,            
                                           UpdatedTransactionDate = @UpdatedTransactionDate,
                                           UpdatedByUserID = @UpdatedByUserID
                                     WHERE TransactionID = @TransactionID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@TransactionID", TransactionID);


                    if (ReturnID != null)
                        command.Parameters.AddWithValue("@ReturnID", ReturnID);
                    else
                        command.Parameters.AddWithValue("@ReturnID", DBNull.Value);

                    if (ActualTotalDueAmount != null)
                        command.Parameters.AddWithValue("@ActualTotalDueAmount", ActualTotalDueAmount);
                    else
                        command.Parameters.AddWithValue("@ActualTotalDueAmount", DBNull.Value);

                    if (TotalRemaining != null)
                        command.Parameters.AddWithValue("@TotalRemaining", TotalRemaining);
                    else
                        command.Parameters.AddWithValue("@TotalRemaining", DBNull.Value);

                    if (TotalRefundedAmount != null)
                        command.Parameters.AddWithValue("@TotalRefundedAmount", TotalRefundedAmount);
                    else
                        command.Parameters.AddWithValue("@TotalRefundedAmount", DBNull.Value);

                    if (UpdatedTransactionDate != null)
                        command.Parameters.AddWithValue("@UpdatedTransactionDate", UpdatedTransactionDate);
                    else
                        command.Parameters.AddWithValue("@UpdatedTransactionDate", DBNull.Value);

                    if (UpdatedByUserID != null)
                        command.Parameters.AddWithValue("@UpdatedByUserID", UpdatedByUserID);
                    else
                        command.Parameters.AddWithValue("@UpdatedByUserID", DBNull.Value);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Rental Transaction
        public static bool DeleteRentalTransaction(int TransactionID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM RentalTransaction WHERE TransactionID = @TransactionID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@TransactionID", TransactionID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Get All Rental Transaction
        public static DataTable GetAllRentalTransaction()
        {
            DataTable dtAllRentalTransaction = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM RentalTransaction_View;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                dtAllRentalTransaction = new DataTable();
                                dtAllRentalTransaction.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllRentalTransaction = null;
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return dtAllRentalTransaction;
        }


        // Get Payment Details By Booking ID
        public static string GetPaymentDetailsByBookingID(int BookingID)
        {
            string PaymentDetails = "";

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT PaymentDetails FROM RentalTransaction WHERE BookingID = @BookingID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@BookingID", BookingID);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null)
                            PaymentDetails = (string)Result;
                    }
                    catch (SqlException sqlex)
                    {
                        PaymentDetails = "";
                        clsEventLogHandler.LogException("DAL - RentalTransaction", sqlex.Message);
                    }
                }
            }

            return PaymentDetails;
        }
    }
}