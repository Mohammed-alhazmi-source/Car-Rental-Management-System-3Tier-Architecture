using CRMS.GlobalClasses;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.FuelTypes
{
    public partial class frmAddUpdateFuelType : Form
    {
        private clsEnums.enMode _Mode = clsEnums.enMode.Add;

        private int _FuelTypeID = -1;
        
        private clsFuelType _FuelType = null;

        public event Action<int> OnAddUpdateFuelType;
        protected virtual void AddUpdateFuelType(int FuelTypeID)
        {
            Action<int> handler = OnAddUpdateFuelType;

            if (handler != null)
                handler(FuelTypeID);
        }

        public frmAddUpdateFuelType()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateFuelType(int FuelTypeID)
        {
            InitializeComponent();
            _FuelTypeID = FuelTypeID;
            _Mode = clsEnums.enMode.Update;
        }

        private void frmAddUpdateFuelType_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadFuelTypeInfo();
        }

        private void _ResetDefaultValues()
        {
            if (_Mode == clsEnums.enMode.Add)
            {
                lblFuelTypeID.Text = "[???]";
                lblTitle.Text = "Add New Fuel Type";
                _FuelType = new clsFuelType();
            }
            else
                lblTitle.Text = "Update Fuel Type";

            txtFuelType.Text = "";
        }

        private void _LoadFuelTypeInfo()
        {
            _FuelType = clsFuelType.Find(_FuelTypeID);

            if (_FuelType == null)
            {
                MessageBox.Show($"Not Found Fuel Type ID = {_FuelTypeID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblFuelTypeID.Text = _FuelType.FuelTypeID.ToString();
            txtFuelType.Text = _FuelType.FuelType;
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtFuelType.Text))
            {
                txtFuelType_Validating(txtFuelType, new CancelEventArgs());
                return false;
            }
            return true;
        }

        private void _ValidateFuelType(CancelEventArgs e)
        {
            if(clsFuelType.IsExist(txtFuelType.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtFuelType, "The Fuel Name Is Used Another Fuel Type");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtFuelType, null);
            }
        }

        private void txtFuelType_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtFuelType.Text))
            {
                errorProvider1.SetError(txtFuelType, "This Filed Is Required");
                return;
            }
            else
                errorProvider1.SetError(txtFuelType, null);

            if(_Mode == clsEnums.enMode.Update)
            {
                if (txtFuelType.Text != _FuelType.FuelType)
                    _ValidateFuelType(e);
                
                return;
            }

            // Add Mode
            _ValidateFuelType(e);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _FuelType.FuelType = txtFuelType.Text.Trim();

            if (_FuelType.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblFuelTypeID.Text = _FuelType.FuelTypeID.ToString();
                lblTitle.Text = "Update Fuel Type";
                _Mode = clsEnums.enMode.Update;
                AddUpdateFuelType(_FuelType.FuelTypeID);
            }
            else
                MessageBox.Show("Doesn't Save Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void frmAddUpdateFuelType_Activated(object sender, EventArgs e) => txtFuelType.Focus();

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}