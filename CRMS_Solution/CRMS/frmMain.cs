using CRMS.Customer;
using CRMS.FuelTypes;
using CRMS.GlobalClasses;
using CRMS.Login;
using CRMS.Make;
using CRMS.MakeModels;
using CRMS.People;
using CRMS.RentalBooking;
using CRMS.RentalTransaction;
using CRMS.User;
using CRMS.Vehicle;
using CRMS.VehicleCategories;
using CRMS.VehicleReturn;
using System;
using System.Windows.Forms;

namespace CRMS
{
    public partial class frmMain : Form
    {
        private frmLogin _frmLogin;
        public frmMain(frmLogin Login)
        {
            InitializeComponent();
            _frmLogin = Login;
        }

        private void PeopleItem_Click(object sender, EventArgs e)
        {
            frmListPeople listPeople = new frmListPeople();
            listPeople.ShowDialog();
        }

        private void UsersItem_Click(object sender, EventArgs e)
        {
            frmListUsers listUsers = new frmListUsers();
            listUsers.ShowDialog();
        }

        private void CustomersItem_Click(object sender, EventArgs e)
        {
            frmListCustomers listCustomers = new frmListCustomers();
            listCustomers.ShowDialog();
        }

        private void CurrentUserInfoItem_Click(object sender, EventArgs e)
        {
            frmShowCurrentUserInfo currentUserInfo = new frmShowCurrentUserInfo(clsGlobal.CurrentUser.UserID);
            currentUserInfo.ShowDialog();
        }

        private void ChangePasswordItem_Click(object sender, EventArgs e)
        {
            frmChangePassword changePassword = new frmChangePassword(clsGlobal.CurrentUser.UserID);
            changePassword.ShowDialog();
        }

        private void SignOutItem_Click(object sender, EventArgs e)
        {
            clsGlobal.CurrentUser = null;

            this.Hide();
            _frmLogin.Show();
        }

        private void frmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void ManagementMakesItem_Click(object sender, EventArgs e)
        {
            frmListMakes listMakes = new frmListMakes();
            listMakes.ShowDialog();
        }

        private void ManagementMakeModelsItem_Click(object sender, EventArgs e)
        {
            frmListModels listModels = new frmListModels();
            listModels.ShowDialog();
        }

        private void ManagementFuelTypesItem_Click(object sender, EventArgs e)
        {
            frmListFuelTypes listFuelTypes = new frmListFuelTypes();
            listFuelTypes.ShowDialog();
        }

        private void ManagementCategoriesItem_Click(object sender, EventArgs e)
        {
            frmListCategories listCategories = new frmListCategories();
            listCategories.ShowDialog();
        }

        private void ManagementVehiclesItem_Click(object sender, EventArgs e)
        {
            frmListVehicles listVehicles = new frmListVehicles();
            listVehicles.ShowDialog();
        }

        private void AddNewBookingItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateRentalBooking AddRentalBooking = new frmAddUpdateRentalBooking();
            AddRentalBooking.ShowDialog();
        }

        private void ManagementRentalsBookingItem_Click(object sender, EventArgs e)
        {
            frmListRentalsBooking listRentalsBooking = new frmListRentalsBooking();
            listRentalsBooking.ShowDialog();
        }

        private void VehicleReturnItem_Click(object sender, EventArgs e)
        {
            frmVehicleReturn vehicleReturn = new frmVehicleReturn();
            vehicleReturn.ShowDialog();
        }

        private void ManagementVehiclesReturnItem_Click(object sender, EventArgs e)
        {
            frmListVehiclesReturn listVehiclesReturn = new frmListVehiclesReturn();
            listVehiclesReturn.ShowDialog();
        }

        private void ManagementRentalsTransactionItem_Click(object sender, EventArgs e)
        {
            frmListRentalsTransaction listRentalsTransaction = new frmListRentalsTransaction();
            listRentalsTransaction.ShowDialog();
        }
    }
}