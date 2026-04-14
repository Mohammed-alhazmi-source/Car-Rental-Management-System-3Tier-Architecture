using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsVehicleData
    {
        // Get Vehicle Info By ID
        public static bool GetVehicleInfoByID
            (
                int VehicleID, ref int MakeID, ref int ModelID, ref int Year, ref int Mileage, ref int FuelTypeID,
                ref int PlateNumber, ref int CarCategoryID, ref decimal RentalPricePerDay,
                ref bool IsAvailableForRent, ref int CreatedByUserID, ref string ImagePath               
            )
        {
            bool IsFind = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Vehicles WHERE VehicleID = @VehicleID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);

                    try
                    {
                        connection.Open();

                        using(SqlDataReader reader =  command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                ModelID = (int)reader["ModelID"];
                                Year = (int)reader["Year"];
                                Mileage = (int)reader["Mileage"];
                                FuelTypeID = (int)reader["FuelTypeID"];
                                PlateNumber = (int)reader["PlateNumber"];
                                MakeID = (int)reader["MakeID"];
                                CarCategoryID = (int)reader["CarCategoryID"];
                                RentalPricePerDay = (decimal)reader["RentalPricePerDay"];
                                IsAvailableForRent = (bool)reader["IsAvailableForRent"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];

                                if (reader["ImagePath"] == DBNull.Value)
                                    ImagePath = null;
                                else
                                    ImagePath = (string)reader["ImagePath"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }



        // Get Vehicle Info By ID And By MakeID And By Model ID
        public static bool GetVehicleInfoByIDAndMakeIDAndModelID
            (
                int VehicleID, int MakeID, int ModelID, ref int Year, ref int Mileage, ref int FuelTypeID,
                ref int PlateNumber, ref int CarCategoryID, ref decimal RentalPricePerDay,
                ref bool IsAvailableForRent, ref int CreatedByUserID, ref string ImagePath
            )
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"SELECT * FROM Vehicles 
                                 WHERE VehicleID = @VehicleID AND 
                                 MakeID = @MakeID AND
                                 ModelID = @ModelID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@ModelID", ModelID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            IsFind = true;
                            Year = (int)reader["Year"];
                            Mileage = (int)reader["Mileage"];
                            FuelTypeID = (int)reader["FuelTypeID"];
                            PlateNumber = (int)reader["PlateNumber"];
                            CarCategoryID = (int)reader["CarCategoryID"];
                            RentalPricePerDay = (decimal)reader["RentalPricePerDay"];
                            IsAvailableForRent = (bool)reader["IsAvailableForRent"];
                            CreatedByUserID = (int)reader["CreatedByUserID"];

                            if (reader["ImagePath"] == DBNull.Value)
                                ImagePath = null;
                            else
                                ImagePath = (string)reader["ImagePath"];                         
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Vehicle Info By MakeName And ModelName
        public static bool GetVehicleInfoByMakeNameAndModelName
            (
                string MakeName, string ModelName,
                ref int VehicleID, ref int MakeID, ref int ModelID, ref int Year, ref int Mileage, ref int FuelTypeID,
                ref int PlateNumber, ref int CarCategoryID, ref decimal RentalPricePerDay,
                ref bool IsAvailableForRent, ref int CreatedByUserID, ref string ImagePath
            )
        {
            bool IsFind = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    SELECT V.*
                                    FROM Vehicles V
                                    JOIN Makes M
                                    ON V.MakeID = M.MakeID
                                    JOIN MakeModels MM
                                    ON V.ModelID = MM.ModelID
                                    WHERE M.MakeName = @MakeName AND MM.ModelName = @ModelName;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@MakeName", MakeName);
                    command.Parameters.AddWithValue("@ModelName", ModelName);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFind = true;
                                VehicleID = (int)reader["VehicleID"];
                                MakeID = (int)reader["MakeID"];
                                ModelID = (int)reader["ModelID"];
                                Year = (int)reader["Year"];
                                Mileage = (int)reader["Mileage"];
                                FuelTypeID = (int)reader["FuelTypeID"];
                                PlateNumber = (int)reader["PlateNumber"];
                                CarCategoryID = (int)reader["CarCategoryID"];
                                RentalPricePerDay = (decimal)reader["RentalPricePerDay"];
                                IsAvailableForRent = (bool)reader["IsAvailableForRent"];
                                CreatedByUserID = (int)reader["CreatedByUserID"];

                                if (reader["ImagePath"] == DBNull.Value)
                                    ImagePath = null;
                                else
                                    ImagePath = (string)reader["ImagePath"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFind = false;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return IsFind;
        }


        // Get Vehicles Info By Make ID
        public static DataTable GetAllVehiclesByMakeName(string MakeName)
        {
            DataTable dtAllVehicles = null;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Vehicles_View where MakeName = @MakeName;";

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
                                dtAllVehicles = new DataTable();
                                dtAllVehicles.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllVehicles = null;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return dtAllVehicles;
        }

        // Add New Vehicle
        public static int AddNewVehicle
            (
                int MakeID, int ModelID, int Year, int Mileage, int FuelTypeID, int PlateNumber,
                int CarCategoryID, decimal RentalPricePerDay, bool IsAvailableForRent, 
                int CreatedByUserID, string ImagePath
            )
        {
            int VehicleID = -1;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                    INSERT INTO Vehicles
                                    					(
                                    						MakeID, 
                                    						ModelID, 
                                    						Year, 
                                    						Mileage, 
                                    						FuelTypeID, 
                                    						PlateNumber, 
                                    						CarCategoryID, 
                                    						RentalPricePerDay, 
                                    						IsAvailableForRent, 
                                    						CreatedByUserID
                                    				    )
                                    VALUES
                                    					(
                                    						@MakeID, 
                                    						@ModelID, 
                                    						@Year, 
                                    						@Mileage, 
                                    						@FuelTypeID, 
                                    						@PlateNumber, 
                                    						@CarCategoryID, 
                                    						@RentalPricePerDay, 
                                    						@IsAvailableForRent,
                                    						@CreatedByUserID
                                    					);
                                    SELECT SCOPE_IDENTITY();";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@ModelID", ModelID);
                    command.Parameters.AddWithValue("@Year", Year);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@FuelTypeID", FuelTypeID);
                    command.Parameters.AddWithValue("@PlateNumber", PlateNumber);
                    command.Parameters.AddWithValue("@CarCategoryID", CarCategoryID);
                    command.Parameters.AddWithValue("@RentalPricePerDay", RentalPricePerDay);
                    command.Parameters.AddWithValue("@IsAvailableForRent", IsAvailableForRent);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    if (string.IsNullOrEmpty(ImagePath))
                        command.Parameters.AddWithValue("@ImagePath", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@ImagePath", ImagePath);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            VehicleID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        VehicleID = -1;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return VehicleID;
        }


        // Update Vehicle
        public static bool UpdateVehicle
            (
                int VehicleID, int MakeID, int ModelID, int Year, int Mileage, int FuelTypeID, int PlateNumber,
                int CarCategoryID, decimal RentalPricePerDay, bool IsAvailableForRent, 
                int CreatedByUserID, string ImagePath
            )
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"UPDATE Vehicles 
                                SET 
                                    MakeID = @MakeID,
                                    ModelID = @ModelID,
                                    Year = @Year,
                                    Mileage = @Mileage,
                                    FuelTypeID = @FuelTypeID,
                                    PlateNumber = @PlateNumber,
                                    CarCategoryID = @CarCategoryID,
                                    RentalPricePerDay = @RentalPricePerDay,
                                    IsAvailableForRent = @IsAvailableForRent,
                                    CreatedByUserID = @CreatedByUserID                                   
                                WHERE VehicleID = @VehicleID;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);
                    command.Parameters.AddWithValue("@MakeID", MakeID);
                    command.Parameters.AddWithValue("@ModelID", ModelID);
                    command.Parameters.AddWithValue("@Year", Year);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@FuelTypeID", FuelTypeID);
                    command.Parameters.AddWithValue("@PlateNumber", PlateNumber);
                    command.Parameters.AddWithValue("@CarCategoryID", CarCategoryID);
                    command.Parameters.AddWithValue("@RentalPricePerDay", RentalPricePerDay);
                    command.Parameters.AddWithValue("@IsAvailableForRent", IsAvailableForRent);
                    command.Parameters.AddWithValue("@CreatedByUserID", CreatedByUserID);

                    if (string.IsNullOrEmpty(ImagePath))
                        command.Parameters.AddWithValue("@ImagePath", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@ImagePath", ImagePath);                   
                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Is Plate Number Exist
        public static bool IsExist(int PlateNumber)
        {
            bool IsExisting = false;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM Vehicles WHERE PlateNumber = @PlateNumber;";

                using(SqlCommand command = new SqlCommand(Query,connection))
                {
                    command.Parameters.AddWithValue("@PlateNumber", PlateNumber);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int ValueNumber))
                            IsExisting = true;
                    }
                    catch (SqlException sqlex)
                    {
                        IsExisting = false;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return IsExisting;
        }

        // Update State Vehicle
        public static bool UpdateState(int VehicleID)
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"UPDATE Vehicles 
                                SET                                                            
                                    IsAvailableForRent = 1,
                                WHERE VehicleID = @VehicleID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Delete Vehicle
        public static bool DeleteVehicle(int VehicleID)
        {
            int RowsAffected = 0;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM Vehicles WHERE VehicleID = @VehicleID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@VehicleID", VehicleID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // Get All Vehicles
        public static DataTable GetAllVehicles()
        {
            DataTable dtAllVehicles = null;

            using(SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM Vehicles_View;";

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
                        clsEventLogHandler.LogException("DAL - Vehicles", sqlex.Message);
                    }
                }
            }

            return dtAllVehicles;
        }
    }
}