using CRMS.GlobalClasses;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.Customer
{
    public partial class frmAddUpdateCustomer : Form
    {
        private int _CustomerID = -1;
        private clsEnums.enMode _Mode = clsEnums.enMode.Add;

        private clsCustomer _Customer = null;

        public event Action<int> OnSaved;

        public frmAddUpdateCustomer()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateCustomer(int CustomerID)
        {
            InitializeComponent();
            _CustomerID = CustomerID;
            _Mode = clsEnums.enMode.Update;
        }

        private void _ResetDefaultValues()
        {
            if(_Mode == clsEnums.enMode.Add)
            {
                lblCustomerID.Text = "[???]";
                lblTitle.Text = "Add New Customer";
                _Customer = new clsCustomer();
            }

            else
                lblTitle.Text = "Update Customer";

            txtCustomerName.Text = "";
            txtDriverLicenseNumber.Text = "";
            txtPhone.Text = "";
        }

        private void _LoadCustomerInfo()
        {
            _Customer = clsCustomer.Find(_CustomerID);

            if(_Customer == null)
            {
                MessageBox.Show($"This Customer Not Found ID = {_CustomerID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblCustomerID.Text = _Customer.CustomerID.ToString();
            txtCustomerName.Text = _Customer.CustomerName;
            txtDriverLicenseNumber.Text= _Customer.DriverLicenseNumber.ToString();
            txtPhone.Text = _Customer.Phone.ToString();
        }
      
        public override bool ValidateChildren()
        {
            bool IsValid = true;

            if(string.IsNullOrEmpty(txtCustomerName.Text))
            {
                txtCustomerName_Validating(txtCustomerName, null);
                IsValid = false;
            }

            if(string.IsNullOrEmpty(txtPhone.Text))
            {
                txtPhone_Validating(txtPhone, null);
                IsValid = false;
            }

            if(string.IsNullOrEmpty(txtDriverLicenseNumber.Text))
            {
                txtDriverLicenseNumber_Validating(txtDriverLicenseNumber, null);
                IsValid = false;
            }

            return IsValid;
        }

        private void _ValidatePhoneNumber(CancelEventArgs e)
        {
            if (clsCustomer.IsExist(txtPhone.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtPhone, "The Phone Number Is Used Another Customer");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtPhone, null);
            }
        }

        private void _ValidateDriverLicenseNumber(CancelEventArgs e)
        {
            if(clsCustomer.IsDriverLicenseExist(Convert.ToInt32(txtDriverLicenseNumber.Text)))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtDriverLicenseNumber, "The License Number Is Used Another Customer");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtDriverLicenseNumber, null);
            }
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");
            else
                errorProvider1.SetError(Temp, null);
        }

        private void frmAddUpdateCustomer_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadCustomerInfo();
        }

        private void txtCustomerName_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtPhone.Text))
            { 
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if(_Mode == clsEnums.enMode.Update)
            {
                if(txtPhone.Text != _Customer.Phone)
                {
                    _ValidatePhoneNumber(e);
                }
                return;
            }

            // In State Add Mode
            _ValidatePhoneNumber(e);
        }

        private void txtDriverLicenseNumber_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrEmpty(txtDriverLicenseNumber.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if(_Mode == clsEnums.enMode.Update)
            {
                if(txtDriverLicenseNumber.Text != _Customer.DriverLicenseNumber.ToString())
                {
                    _ValidateDriverLicenseNumber(e);
                }
                return;
            }

            // In State Add Mode
            _ValidateDriverLicenseNumber(e);
        }

        private void txtPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtDriverLicenseNumber_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _Customer.CustomerName = txtCustomerName.Text;
            _Customer.Phone = txtPhone.Text.Trim();
            _Customer.DriverLicenseNumber = Convert.ToInt32(txtDriverLicenseNumber.Text);
            _Customer.CreatedByUserID = clsGlobal.CurrentUser.UserID;

            if (_Customer.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblCustomerID.Text = _Customer.CustomerID.ToString();
                lblTitle.Text = "Update Customer";
                _Mode = clsEnums.enMode.Update;
                OnSaved?.Invoke(_Customer.CustomerID);
            }

            else
                MessageBox.Show("Doesn't Saved Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void frmAddUpdateCustomer_Activated(object sender, EventArgs e)
        {
            txtCustomerName.Focus();
        }
    }
}