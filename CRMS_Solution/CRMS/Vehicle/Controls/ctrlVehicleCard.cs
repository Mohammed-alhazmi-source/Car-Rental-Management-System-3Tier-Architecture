using CRMS.Properties;
using CRMS_Business;
using System;
using System.IO;
using System.Windows.Forms;

namespace CRMS.Vehicle.Controls
{
    public partial class ctrlVehicleCard : UserControl
    {
        private int _VehicleID = -1;
        public int VehicleID => _VehicleID;

        private clsVehicle _Vehicle = null;
        public clsVehicle VehicleSelectedInfo => _Vehicle;

        public event Action<int> OnVehicleChanged;
        protected virtual void VehicleChange(int VehicleID)
        {
            Action<int> handler = OnVehicleChanged;

            if (handler != null)
                handler(VehicleID);
        }

        private void _ResetDefaultValues()
        {
            llEditVehicleInfo.Enabled = false;
            _VehicleID = -1;
            lblVehicleID.Text = "[???]";
            lblMakeID.Text = "[???]";
            lblMakeName.Text = "[???]";
            lblModelID.Text = "[???]";
            lblModelName.Text = "[???]";
            lblYear.Text = "[???]";
            lblPlateNumber.Text = "[???]";
            lblMileage.Text = "[???]";
            lblFuelTypeID.Text = "[???]";
            lblFuelType.Text = "[???]";
            lblRentalPricePerDay.Text = "[???]";
            lblCategoryID.Text = "[???]";
            lblCategoryName.Text = "[???]";
            lblIsAvailableForRent.Text = "[???]";
            lblCreatedBy.Text = "[???]";
            pbVehicleImage.Image = Resources.wallpaper;
        }

        private void _LoadVehicleImage()
        {
            if (_Vehicle is null)
            {
                pbVehicleImage.Image = Resources.wallpaper;
                return;
            }

            if(string.IsNullOrEmpty(_Vehicle.ImagePath))
            {
                pbVehicleImage.Image = Resources.wallpaper;
                return;
            }

            if(!File.Exists(_Vehicle.ImagePath))
            {
                pbVehicleImage.ImageLocation = "Image Path Not Found";
                return;
            }

            pbVehicleImage.ImageLocation = _Vehicle.ImagePath;
        }

        private void _FillVehicleInfoInControls()
        {
            llEditVehicleInfo.Enabled = true;
            _VehicleID = _Vehicle.VehicleID;
            lblVehicleID.Text = _Vehicle.VehicleID.ToString();
            lblMakeID.Text = _Vehicle.MakeID.ToString();
            lblMakeName.Text = _Vehicle.MakeInfo.MakeName;
            lblModelID.Text = _Vehicle.ModelID.ToString();
            lblModelName.Text = _Vehicle.ModelInfo.ModelName;
            lblYear.Text = _Vehicle.Year.ToString();
            lblPlateNumber.Text = _Vehicle.PlateNumber.ToString();
            lblMileage.Text = _Vehicle.Mileage.ToString();
            lblFuelTypeID.Text = _Vehicle.FuelTypeID.ToString();
            lblFuelType.Text = _Vehicle.FuelTypeInfo.FuelType;
            lblRentalPricePerDay.Text = ((int)_Vehicle.RentalPricePerDay).ToString();
            lblCategoryID.Text = _Vehicle.CarCategoryID.ToString();
            lblCategoryName.Text = _Vehicle.CategoryInfo.CategoryName;
            lblIsAvailableForRent.Text = _Vehicle.IsAvailableForRent ? "No" : "Yes";
            lblCreatedBy.Text = _Vehicle.CreatedByUserID.ToString();
            _LoadVehicleImage();
        }

        public void LoadVehicleInfo(int VehicleID)
        {
            _Vehicle = clsVehicle.Find(VehicleID);

            if(_Vehicle == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Vehicle With ID = {VehicleID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillVehicleInfoInControls();
        }

        public void LoadVehicleInfo(string MakeName, string ModelName)
        {
            _Vehicle = clsVehicle.Find(MakeName, ModelName);

            if (_Vehicle == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Vehicle With MakeName = {MakeName} And ModelName {ModelName}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillVehicleInfoInControls();
        }

        public ctrlVehicleCard()
        {
            InitializeComponent();
        }

        private void llEditVehicleInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateVehicle EditVehicle = new frmAddUpdateVehicle(Convert.ToInt32(lblVehicleID.Text));
            EditVehicle.OnVehicleChanged += EditVehicle_OnVehicleChanged;
            EditVehicle.ShowDialog();
        }

        private void EditVehicle_OnVehicleChanged(int VehicleID)
        {
            LoadVehicleInfo(VehicleID);
            VehicleChange(VehicleID);
        }
    }
}