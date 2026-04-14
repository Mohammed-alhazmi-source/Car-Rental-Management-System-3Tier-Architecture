using CRMS.GlobalClasses;
using CRMS.Make.Controls;
using CRMS.Properties;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Windows.Forms;
using static CRMS.GlobalClasses.clsEnums;

namespace CRMS.Vehicle
{
    public partial class frmAddUpdateVehicle : Form
    {
        private enMode _Mode = enMode.Add;

        private int _MakeID = -1;

        private int _VehicleID = -1;


        // حدث يطلق معرف المركبة لتنفيذ منطق معين
        public event Action<int> OnVehicleChanged;
        protected virtual void VehicleChanged(int VehicleID)
        {
            Action<int> handler = OnVehicleChanged;

            if (handler != null)
                handler(VehicleID);
        }


        // حدث يتم اطلاقة ويقوم بارسال حقيبة او كائن يحتوي على معلومات المركبة لتنفيذ منطق معين
        public class VehicleSelectedEventArgs : EventArgs
        {
            public clsVehicle VehicleInfo { get; set; }

            public VehicleSelectedEventArgs(clsVehicle vehicleInfo)
            {
                VehicleInfo = vehicleInfo;
            }
        }
        public event EventHandler<VehicleSelectedEventArgs> OnVehicleSelected;
        private void _VehicleSelected(clsVehicle VehicleInfo)
        {
            VehicleSelected(new VehicleSelectedEventArgs(VehicleInfo));
        }
        protected virtual void VehicleSelected(VehicleSelectedEventArgs e)
        {
            OnVehicleSelected?.Invoke(this, e);
        }

        private clsVehicle _Vehicle = null;

        public frmAddUpdateVehicle()
        {
            InitializeComponent();
            _Mode = enMode.Add;
        }

        public frmAddUpdateVehicle(int VehicleID)
        {
            InitializeComponent();
            _VehicleID = VehicleID;
            _Mode = enMode.Update;
        }

        private void frmAddUpdateVehicle_Load(object sender, EventArgs e)
        {
            tpVehicleInfo.Enabled = false;
            btnRemoveImage.Visible = false;

            _ResetDefaultValues();

            if (_Mode == enMode.Update)
                _LoadVehicleInfo();
        }

        private void _ResetDefaultValues()
        {            
            if (_Mode == enMode.Add)
            {
                lblVehicleID.Text = "[???]";
                lblMakeName.Text = "[???]";
                lblTitle.Text = "Add New Vehicle";
                _Vehicle = new clsVehicle();
            }

            else
                lblTitle.Text = "Update Vehicle";

            txtMileage.Text = "";
            txtPlateNumber.Text = "";
            txtRentalPricePerDay.Text = "";
            txtYear.Text = "";
            _LoadVehicleImage();
        }

        private bool ValidateChildren(object sender ,Predicate<string> predicate)
        {
            TextBox Temp = (TextBox)sender;

            return predicate(Temp.Text);
        }

        public override bool ValidateChildren()
        {
            bool Valid = true;

            if(ValidateChildren(txtMileage, txt => string.IsNullOrEmpty(txt)))
            {
                txtMileage_Validating(txtMileage, new CancelEventArgs());
                Valid = false;
            }

            if (ValidateChildren(txtYear, txt => string.IsNullOrEmpty(txt)))
            {
                txtYear_Validating(txtYear, new CancelEventArgs());
                Valid = false;
            }

            if (ValidateChildren(txtPlateNumber, txt => string.IsNullOrEmpty(txt)))
            {
                txtPlateNumber_Validating(txtPlateNumber, new CancelEventArgs());
                Valid = false;
            }

            if (ValidateChildren(txtRentalPricePerDay, txt => string.IsNullOrEmpty(txt)))
            {
                txtRentalPricePerDay_Validating(txtRentalPricePerDay, new CancelEventArgs());
                Valid = false;
            }

            return Valid;
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");
            else
                errorProvider1.SetError(Temp, null);
        }

        private void _FillModelsInComboBox()
        {
            DataTable dtModels = clsMakeModel.GetAllModelsByMakeID(ctrlMakeCardWithFilter1.MakeID);

            if (dtModels == null)
            {
                cbModels.Items.Add("Not Found Any Mode");
                cbModels.SelectedIndex = 0;
                btnSave.Enabled = false;
                return;
            }

            foreach (DataRow Row in dtModels.Rows)
                cbModels.Items.Add(Row["ModelName"]);

            // Mode Add
            cbModels.SelectedIndex = 0;

            if (_Mode == enMode.Update)
                cbModels.SelectedIndex = cbModels.FindString(_Vehicle.ModelInfo.ModelName);
        }

        private void _FillFuelTypesInComboBox()
        {
            if (cbFuelTypes.Items.Count > 0)
                return;

            DataTable dtFuelTypes = clsFuelType.GetAllFuelTypes();

            if(dtFuelTypes == null)
            {
                cbFuelTypes.Items.Add("Not Found Any Fuel Type");
                cbFuelTypes.SelectedIndex = 0;
                btnSave.Enabled = false;
                return;
            }

            foreach (DataRow Row in dtFuelTypes.Rows)
                cbFuelTypes.Items.Add(Row["FuelType"]);

            // Mode Add
            cbFuelTypes.SelectedIndex = 0;

            if (_Mode == enMode.Update)
                cbFuelTypes.SelectedIndex = cbFuelTypes.FindString(_Vehicle.FuelTypeInfo.FuelType);
        }

        private void _FillCategoriesInComboBox()
        {
            if (cbCategories.Items.Count > 0)
                return;

            DataTable dtCategories = clsVehicleCategory.GetAllVehicleCategories();

            if(dtCategories == null)
            {
                cbModels.Items.Add("Not Found Any Category");
                cbModels.SelectedIndex = 0;
                btnSave.Enabled = false;
                return;
            }

            foreach (DataRow Row in dtCategories.Rows)
                cbCategories.Items.Add(Row["CategoryName"]);

            // Mode Add
            cbCategories.SelectedIndex = 0;

            if (_Mode == enMode.Update)
                cbCategories.SelectedIndex = cbCategories.FindString(_Vehicle.CategoryInfo.CategoryName);
        }

        private void _LoadVehicleImage()
        {
            if(_Mode == enMode.Add || _Vehicle == null)
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
                pbVehicleImage.ImageLocation = "Not Found Image Path";
                return;
            }

            pbVehicleImage.ImageLocation = _Vehicle.ImagePath;
        }

        private void _LoadVehicleInfo()
        {
            _Vehicle = clsVehicle.Find((int)_VehicleID);

            if(_Vehicle == null)
            {
                _ResetDefaultValues();
                MessageBox.Show("Not Found This Vehicle", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            ctrlMakeCardWithFilter1.LoadMakeInfo(_Vehicle.MakeID);
            ctrlMakeCardWithFilter1.FilterEnabled = false;
            lblVehicleID.Text = _Vehicle.VehicleID.ToString();
            lblMakeName.Text = _Vehicle.MakeInfo.MakeName;
            txtMileage.Text = _Vehicle.Mileage.ToString();
            txtYear.Text = _Vehicle.Year.ToString();
            txtPlateNumber.Text = _Vehicle.PlateNumber.ToString();
            txtRentalPricePerDay.Text = ((int)_Vehicle.RentalPricePerDay).ToString();
        }

        private bool _HandleVehicleImage()
        {
            string SourceFile = "";
            if (pbVehicleImage.ImageLocation == null)
            {
                if (!string.IsNullOrEmpty(_Vehicle.ImagePath))
                {
                    File.Delete(_Vehicle.ImagePath);
                    return true;
                }
                return true;
            }

            if (string.IsNullOrEmpty(_Vehicle.ImagePath))
            {
                if (pbVehicleImage.ImageLocation != null)
                {
                    SourceFile = pbVehicleImage.ImageLocation;
                    if (clsUtil.CopyImageToFolderImages(ref SourceFile, "E:\\CRMS_Vehicles_Images"))
                    {
                        pbVehicleImage.ImageLocation = SourceFile;
                        return true;
                    }
                    return false;
                }
            }

            if (!string.IsNullOrEmpty(_Vehicle.ImagePath))
            {
                if (_Vehicle.ImagePath != pbVehicleImage.ImageLocation)
                {
                    try
                    {
                        File.Delete(_Vehicle.ImagePath);
                    }
                    catch (Exception)
                    {
                        return false;
                    }

                    SourceFile = pbVehicleImage.ImageLocation;
                    if (clsUtil.CopyImageToFolderImages(ref SourceFile, "E:\\CRMS_Vehicles_Images"))
                    {
                        pbVehicleImage.ImageLocation = SourceFile;
                        return true;
                    }
                    return false;
                }
            }

            return true;
        }

        private void _ValidateKeyPressToTextBox(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void _ValidatePlateNumber(CancelEventArgs e)
        {
            if(clsVehicle.IsExist(Convert.ToInt32(txtPlateNumber.Text.Trim())))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtPlateNumber, "The Plate Number Is Used Another Vehicle");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtPlateNumber, null);
            }
        }

        private void frmAddUpdateVehicle_Activated(object sender, EventArgs e)
        {
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }

        private void txtYear_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtMileage_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtPlateNumber_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrEmpty(txtPlateNumber.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if(_Mode == enMode.Update)
            {
                if (txtPlateNumber.Text != _Vehicle.PlateNumber.ToString())
                    _ValidatePlateNumber(e);

                return;
            }

            // Mode Add
            _ValidatePlateNumber(e);
        }

        private void txtRentalPricePerDay_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtYear_KeyPress(object sender, KeyPressEventArgs e) => _ValidateKeyPressToTextBox(sender, e);

        private void txtMileage_KeyPress(object sender, KeyPressEventArgs e) => _ValidateKeyPressToTextBox(sender, e);

        private void txtPlateNumber_KeyPress(object sender, KeyPressEventArgs e) => _ValidateKeyPressToTextBox(sender, e);

        private void txtRentalPricePerDay_KeyPress(object sender, KeyPressEventArgs e) => _ValidateKeyPressToTextBox(sender, e);

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            if (!_HandleVehicleImage())
                return;

            _Vehicle.MakeID = _MakeID;
            _Vehicle.ModelID = clsMakeModel.Find(cbModels.Text).ModelID;
            _Vehicle.Year = Convert.ToInt32(txtYear.Text.Trim());
            _Vehicle.Mileage = Convert.ToInt32(txtMileage.Text.Trim());
            _Vehicle.FuelTypeID = clsFuelType.Find(cbFuelTypes.Text).FuelTypeID;
            _Vehicle.PlateNumber = Convert.ToInt32(txtPlateNumber.Text.Trim());
            _Vehicle.CarCategoryID = clsVehicleCategory.Find(cbCategories.Text).CategoryID;
            _Vehicle.RentalPricePerDay = Convert.ToDecimal(txtRentalPricePerDay.Text.Trim());
            _Vehicle.CreatedByUserID = clsGlobal.CurrentUser.UserID;
            _Vehicle.ImagePath = string.IsNullOrEmpty(pbVehicleImage.ImageLocation) ? null : pbVehicleImage.ImageLocation;

            if(_Vehicle.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblVehicleID.Text = _Vehicle.VehicleID.ToString();
                lblTitle.Text = "Update Vehicle";
                _Mode = enMode.Update;
                VehicleChanged(_Vehicle.VehicleID);
                _VehicleSelected(_Vehicle);
            }

            else
                MessageBox.Show("Not Save Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void ctrlMakeCardWithFilter1_OnMakeSelected(object sender, ctrlMakeCardWithFilter.MakeSelectedEventArgs e)
        {
            if(e.Make == null)
            {
                _MakeID = -1;
                btnSave.Enabled = false;
                ctrlMakeCardWithFilter1.txtValueFilterFocus();
                return;
            }

            _MakeID = e.Make.MakeID;
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }

        private void btnNextTab_Click(object sender, EventArgs e)
        {
            if (_Mode == enMode.Update || _MakeID != -1)
            {
                tcVehicle.SelectedTab = tcVehicle.TabPages["tpVehicleInfo"];
                tpVehicleInfo.Enabled = true;
                btnSave.Enabled = true;
            }

            else
            {
                MessageBox.Show("Please Select A Make,", "Select A Make", MessageBoxButtons.OK, MessageBoxIcon.Error);
                ctrlMakeCardWithFilter1.txtValueFilterFocus();
                return;
            }
      
            _FillCategoriesInComboBox();
            _FillFuelTypesInComboBox();
            _FillModelsInComboBox();
            _LoadVehicleImage();
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }

        private void btnChooseImage_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFile = new OpenFileDialog())
            {
                openFile.Filter = "Image File |*.png;*.jpg;*.jpeg;*.gif";
                openFile.ShowDialog();

                if (!string.IsNullOrEmpty(openFile.FileName))
                {
                    pbVehicleImage.ImageLocation = openFile.FileName;
                    btnRemoveImage.Visible = true;
                }
            }
        }

        private void btnRemoveImage_Click(object sender, EventArgs e)
        {
            pbVehicleImage.ImageLocation = null;
            btnRemoveImage.Visible = false;
            pbVehicleImage.Image = Resources.wallpaper;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}