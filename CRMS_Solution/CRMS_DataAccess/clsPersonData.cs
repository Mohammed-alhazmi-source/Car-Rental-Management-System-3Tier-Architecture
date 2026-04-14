using System;
using System.Data;
using System.Data.SqlClient;

namespace CRMS_DataAccess
{
    public class clsPersonData
    {
        // جلب معلومات الشخص بحسب المعرف
        public static bool GetPersonInfoByID
            (
                int PersonID, ref string FirstName, ref string SecondName, ref string ThirdName, ref string LastName,
                ref byte Gender, ref string NationalNo, ref int Nationality, ref string Address,
                ref string Phone, ref string Email, ref DateTime DateOfBirth, ref string ImagePath
            )
        {
            bool IsFound = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM People WHERE PersonID = @PersonID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFound = true;
                                FirstName = (string)reader["FirstName"];
                                SecondName = (string)reader["SecondName"];

                                if (reader["ThirdName"] == DBNull.Value)
                                    ThirdName = "";
                                else
                                    ThirdName = (string)reader["ThirdName"];

                                LastName = (string)reader["LastName"];
                                DateOfBirth = (DateTime)reader["DateOfBirth"];

                                Gender = (bool)reader["Gender"] ? (byte)1: (byte)0;

                                NationalNo = (string)reader["NationalNo"];
                                Nationality = (int)reader["Nationality"]; 
                                Address = (string)reader["Address"];
                                Phone = (string)reader["Phone"];

                                if (reader["Email"] == DBNull.Value)
                                    Email = "";
                                else
                                    Email = (string)reader["Email"];

                                if (reader["ImagePath"] == DBNull.Value)
                                    ImagePath = "";
                                else
                                    ImagePath = (string)reader["ImagePath"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFound = false;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsFound;
        }

        // جلب معلومات الشخص بحسب الرقم الوطني
        public static bool GetPersonInfoByNationalNo
            (
                string NationalNo, ref int PersonID, ref string FirstName, ref string SecondName,
                ref string ThirdName, ref string LastName, ref byte Gender, ref int Nationality, ref string Address,
                ref string Phone, ref string Email, ref DateTime DateOfBirth, ref string ImagePath
            )
        {
            bool IsFound = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM People WHERE NationalNo = @NationalNo;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@NationalNo", NationalNo);

                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                IsFound = true;
                                PersonID = (int)reader["PersonID"];
                                FirstName = (string)reader["FirstName"];
                                SecondName = (string)reader["SecondName"];
                                DateOfBirth = (DateTime)reader["DateOfBirth"];

                                if (reader["ThirdName"] == DBNull.Value)
                                    ThirdName = "";
                                else
                                    ThirdName = (string)reader["ThirdName"];

                                LastName = (string)reader["LastName"];
                                Gender = (bool)reader["Gender"] ? (byte)1 : (byte)0;
                                Nationality = (int)reader["Nationality"];
                                Address = (string)reader["Address"];
                                Phone = (string)reader["Phone"];

                                if (reader["Email"] == DBNull.Value)
                                    Email = "";
                                else
                                    Email = (string)reader["Email"];

                                if (reader["ImagePath"] == DBNull.Value)
                                    ImagePath = "";
                                else
                                    ImagePath = (string)reader["ImagePath"];
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        IsFound = false;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsFound;
        }

        // اضافة شخص
        public static int AddNewPerson
            (
                string FirstName, string SecondName, string ThirdName, string LastName, byte Gender,
                string NationalNo, int Nationality, string Address, string Phone, string Email,
                DateTime DateOfBirth, string ImagePath
            )
        {
            int PersonID = -1;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                  INSERT INTO People
                                             (FirstName, SecondName, ThirdName, LastName, Gender,
                                              NationalNo, Nationality, Address, Phone,
                                              Email,DateOfBirth,ImagePath)
                                       VALUES
                                             (@FirstName, @SecondName, @ThirdName, @LastName, @Gender,
                                              @NationalNo, @Nationality, @Address, @Phone,
                                              @Email, @DateOfBirth,@ImagePath);
                                  SELECT SCOPE_IDENTITY();";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@FirstName", FirstName);
                    command.Parameters.AddWithValue("@SecondName", SecondName);

                    if (string.IsNullOrEmpty(ThirdName))
                        command.Parameters.AddWithValue("@ThirdName", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@ThirdName", ThirdName);

                    command.Parameters.AddWithValue("@LastName", LastName);
                    command.Parameters.AddWithValue("@Gender", Gender);
                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.Parameters.AddWithValue("@Nationality", Nationality);
                    command.Parameters.AddWithValue("@Address", Address);
                    command.Parameters.AddWithValue("@Phone", Phone);

                    if (string.IsNullOrEmpty(Email))
                        command.Parameters.AddWithValue("@Email", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@Email", Email);

                    command.Parameters.AddWithValue("@DateOfBirth", DateOfBirth);

                    if (string.IsNullOrEmpty(ImagePath))
                        command.Parameters.AddWithValue("@ImagePath", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@ImagePath", ImagePath);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        if (Result != null && int.TryParse(Result.ToString(), out int InsertedID))
                            PersonID = InsertedID;
                    }
                    catch (SqlException sqlex)
                    {
                        PersonID = -1;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return PersonID;
        }


        // تعديل بيانات شخص
        public static bool UpdatePerson
            (
                int PersonID, string FirstName, string SecondName, string ThirdName, string LastName,
                byte Gender, string NationalNo, int Nationality, string Address, string Phone,
                string Email, DateTime DateOfBirth, string ImagePath
            )
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = @"
                                  UPDATE People
                                     SET FirstName = @FirstName,
                                  	   SecondName = @SecondName,
                                  	   ThirdName = @ThirdName,
                                         LastName = @LastName,
                                         Gender = @Gender,
                                         NationalNo = @NationalNo,
                                         Nationality = @Nationality,
                                         Address = @Address,
                                         Phone = @Phone,
                                         Email = @Email,
                                         DateOfBirth = @DateOfBirth,
                                         ImagePath = @ImagePath
                                   WHERE PersonID = @PersonID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);
                    command.Parameters.AddWithValue("@FirstName", FirstName);
                    command.Parameters.AddWithValue("@SecondName", SecondName);

                    if (string.IsNullOrEmpty(ThirdName))
                        command.Parameters.AddWithValue("@ThirdName", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@ThirdName", ThirdName);

                    command.Parameters.AddWithValue("@LastName", LastName);
                    command.Parameters.AddWithValue("@Gender", Gender);
                    command.Parameters.AddWithValue("@NationalNo", NationalNo);
                    command.Parameters.AddWithValue("@Nationality", Nationality);
                    command.Parameters.AddWithValue("@Address", Address);
                    command.Parameters.AddWithValue("@Phone", Phone);

                    if (string.IsNullOrEmpty(Email))
                        command.Parameters.AddWithValue("@Email", DBNull.Value);
                    else
                        command.Parameters.AddWithValue("@Email", Email);

                    command.Parameters.AddWithValue("@DateOfBirth", DateOfBirth);

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
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // حذف بيانات شخص
        public static bool DeletePerson(int PersonID)
        {
            int RowsAffected = 0;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "DELETE FROM People WHERE PersonID = @PersonID;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@PersonID", PersonID);

                    try
                    {
                        connection.Open();

                        RowsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException sqlex)
                    {
                        RowsAffected = 0;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return (RowsAffected > 0);
        }


        // تحقق هل الرقم الوطني يوجد من قبل 
        public static bool IsNationalNoExist(string NationalNo)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM People WHERE NationalNo = @NationalNo;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@NationalNo", NationalNo);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        IsExist = (Result != null);
                    }
                    catch (SqlException sqlex)
                    {
                        IsExist = false;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }


        // تحقق هل رقم الهاتف يوجد من قبل
        public static bool IsPhoneExist(string Phone)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM People WHERE Phone = @Phone;";

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
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }


        // تحقق هل البريد الالكتروني يوجد من قبل
        public static bool IsEmailExist(string Email)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT Found = 1 FROM People WHERE Email = @Email;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@Email", Email);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        IsExist = (Result != null);
                    }
                    catch (SqlException sqlex)
                    {
                        IsExist = false;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }


        public static bool IsExist(string Column, string Value)
        {
            bool IsExist = false;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = $"SELECT Found = 1 FROM People WHERE {Column} = @Value;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@Value", Value);

                    try
                    {
                        connection.Open();

                        object Result = command.ExecuteScalar();

                        IsExist = (Result != null);
                    }
                    catch (SqlException sqlex)
                    {
                        IsExist = false;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return IsExist;
        }


        // ارجاع معلومات جميع الاشخاص
        public static DataTable GetAllPeople()
        {
            DataTable dtAllPeople = null;

            using (SqlConnection connection = new SqlConnection(clsDataAccessSettings.ConnectionString))
            {
                string Query = "SELECT * FROM People_View;";

                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                dtAllPeople = new DataTable();
                                dtAllPeople.Load(reader);
                            }
                        }
                    }
                    catch (SqlException sqlex)
                    {
                        dtAllPeople = null;
                        clsEventLogHandler.LogException("DAL - People", sqlex.Message);
                    }
                }
            }

            return dtAllPeople;
        }
    }
}