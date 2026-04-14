using CRMS_DataAccess;
using System;
using System.Data;

namespace CRMS_Business
{
    public class clsPerson
    {
        public enum enMode { Add = 0, Update = 1 };
        public enMode Mode = enMode.Add;

        public enum enColumn { NationalNo = 0, Phone = 1, Email = 2 };

        public int PersonID { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string ThirdName { get; set; }
        public string LastName { get; set; }
        public string FullName => $"{FirstName} {SecondName} {ThirdName} {LastName}";
        public byte Gender { get; set; }
        public string NationalNo { get; set; }
        public int Nationality { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string ImagePath { get; set; }
        public int Age => (DateTime.Now.Year - DateOfBirth.Year);

        public clsCountry CountryInfo { get; set; }

        public clsPerson()
        {
            PersonID = -1;
            FirstName = "";
            SecondName = "";
            ThirdName = "";
            LastName = "";
            Gender = 0;
            NationalNo = "";
            Nationality = -1;
            Address = "";
            Phone = "";
            Email = "";
            DateOfBirth = DateTime.MinValue;
            ImagePath = "";
            Mode = enMode.Add;
        }

        private clsPerson
            (
                int PersonID, string FirstName, string SecondName, string ThirdName, string LastName,
                byte Gender, string NationalNo, int Nationality, string Address, string Phone,
                string Email, DateTime DateOfBirth, string ImagePath
            )
        {
            this.PersonID = PersonID;
            this.FirstName = FirstName;
            this.SecondName = SecondName;
            this.ThirdName = ThirdName;
            this.LastName = LastName;
            this.Gender = Gender;
            this.NationalNo = NationalNo;
            this.Nationality = Nationality;
            this.Address = Address;
            this.Phone = Phone;
            this.Email = Email;
            this.DateOfBirth = DateOfBirth;
            this.ImagePath = ImagePath;
            this.CountryInfo = clsCountry.Find(this.Nationality);
            Mode = enMode.Update;
        }

        public static clsPerson Find(int PersonID)
        {
            string FirstName = "", SecondName = "", ThirdName = "", LastName = "", Phone = "",
                   Email = "", Address = "", NationalNo = "", ImagePath = "";

            int Nationality = -1;
            byte Gender = 0;
            DateTime DateOfBirth = DateTime.MinValue;

            bool IsFound = clsPersonData.GetPersonInfoByID
                (
                    PersonID, ref FirstName, ref SecondName, ref ThirdName, ref LastName, ref Gender,
                    ref NationalNo, ref Nationality, ref Address, ref Phone, ref Email, ref DateOfBirth,
                    ref ImagePath
                );

            if (IsFound)
                return new clsPerson
                    (
                        PersonID, FirstName, SecondName, ThirdName, LastName, Gender, NationalNo, Nationality,
                        Address, Phone, Email, DateOfBirth, ImagePath
                    );

            return null;
        }

        public static clsPerson Find(string NationalNo)
        {
            string FirstName = "", SecondName = "", ThirdName = "", LastName = "", Phone = "",
                   Email = "", Address = "", ImagePath = "";

            int Nationality = -1, PersonID = -1;
            byte Gender = 0;
            DateTime DateOfBirth = DateTime.MinValue;

            bool IsFound = clsPersonData.GetPersonInfoByNationalNo
                (
                    NationalNo, ref PersonID, ref FirstName, ref SecondName, ref ThirdName, ref LastName, ref Gender,
                    ref Nationality, ref Address, ref Phone, ref Email, ref DateOfBirth, ref ImagePath
                );

            if (IsFound)
                return new clsPerson
                    (
                        PersonID, FirstName, SecondName, ThirdName, LastName, Gender, NationalNo, Nationality,
                        Address, Phone, Email, DateOfBirth, ImagePath
                    );

            return null;
        }

        private bool _AddNewPerson()
        {
            this.PersonID = clsPersonData.AddNewPerson
                (
                    this.FirstName, this.SecondName, this.ThirdName, this.LastName, this.Gender,
                    this.NationalNo, this.Nationality, this.Address, this.Phone, this.Email, this.DateOfBirth,
                    this.ImagePath
                );

            return (this.PersonID != -1);
        }

        private bool _UpdatePerson()
        {
            return clsPersonData.UpdatePerson
                (
                    this.PersonID, this.FirstName, this.SecondName, this.ThirdName, this.LastName, this.Gender,
                    this.NationalNo, this.Nationality, this.Address, this.Phone, this.Email, this.DateOfBirth,
                    this.ImagePath
                );
        }

        public static bool DeletePerson(int PersonID) => clsPersonData.DeletePerson(PersonID);

        public bool DeletePerson() => DeletePerson(this.PersonID);

        public bool Save()
        {
            switch (Mode)
            {
                case enMode.Add:
                    if (_AddNewPerson())
                    {
                        Mode = enMode.Update;
                        return true;
                    }
                    else return false;

                case enMode.Update: return _UpdatePerson();
            }

            return false;
        }

        public static bool IsNationalNoExist(string NationalNo) => clsPersonData.IsNationalNoExist(NationalNo);

        public static bool IsPhoneExist(string Phone) => clsPersonData.IsPhoneExist(Phone);

        public static bool IsEmailExist(string Email) => clsPersonData.IsEmailExist(Email);

        public static bool IsExist(enColumn Column, string Value) => clsPersonData.IsExist(Column.ToString(), Value);

        public static DataTable GetAllPeople() => clsPersonData.GetAllPeople();
    }
}