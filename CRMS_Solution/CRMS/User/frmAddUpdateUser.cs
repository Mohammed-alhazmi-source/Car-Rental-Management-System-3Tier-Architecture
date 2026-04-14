using CRMS.GlobalClasses;
using CRMS.People.Controls;
using CRMS_Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRMS.User
{
    public partial class frmAddUpdateUser : Form
    {
        private clsEnums.enMode _Mode = clsEnums.enMode.Add;
        private int _PersonID = -1;
        private clsUser _User = null;

        public event Action OnSave;

        public class AddUpdateUserEventArgs : EventArgs
        {
            public clsUser User { get; }

            public AddUpdateUserEventArgs(clsUser User)
            {
                this.User = User;
            }
        }

        public event EventHandler<AddUpdateUserEventArgs> OnAddUpdateUser;

        protected virtual void AddUpdateUser(clsUser User)
        {
            OnAddUpdateUser?.Invoke(this, new AddUpdateUserEventArgs(User));    
        }

        public frmAddUpdateUser()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateUser(int PersonID)
        {
            InitializeComponent();
            _PersonID = PersonID;
            _Mode = clsEnums.enMode.Update;
        }

        public override bool ValidateChildren()
        {
            bool IsValid = true;

            if (string.IsNullOrEmpty(txtUserName.Text))
            {
                IsValid = false;
                txtUserName_Validating(txtUserName, null);
            }
            if (string.IsNullOrEmpty(txtPassword.Text))
            {
                IsValid = false;
                txtPassword_Validating(txtPassword, null);
            }
            if (string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                IsValid = false;
                txtConfirmPassword_Validating(txtPassword, null);
            }

            return IsValid;
        }

        private void _ShowHidePassword(object sender, TextBox Temp)
        {
            CheckBox ckb = (CheckBox)sender;

            if (ckb.Checked)
                Temp.PasswordChar = '\0';
            else
                Temp.PasswordChar = '*';
        }

        private void _ResetDefaultValues()
        {
            if (_Mode == clsEnums.enMode.Add)
            {
                lblUserID.Text = "[???]";
                lblTitle.Text = "Add New User";
                _User = new clsUser();
            }
            else
                lblTitle.Text = "Update User";

            tpLoginInfo.Enabled = false;
            btnSave.Enabled = false;
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            ckbIsActive.Checked = true;
        }

        private void _DisabledControls()
        {
            txtPassword.Enabled = false;
            txtConfirmPassword.Enabled = false;
            ckbShowHidePassword.Enabled = false;
            ckbShowHideConfirmPassword.Enabled = false;
        }

        private void _LoadDataUserInfo()
        {
            _User = clsUser.FindByPersonID(_PersonID);

            if (_User == null)
            {
                this.Close();
                return;
            }
            
            ctrlPersonCardWithFilter1.LoadPersonInfo(_PersonID);
            ctrlPersonCardWithFilter1.FilterEnabled = false;
            lblUserID.Text = _User.UserID.ToString();
            txtUserName.Text = _User.UserName;
            txtPassword.Text = _User.Password;
            txtConfirmPassword.Text = _User.Password;
            ckbIsActive.Checked = _User.IsActive;
            _DisabledControls();            
        }

        private void _ValidateUserName(CancelEventArgs e)
        {
            if (clsUser.IsExist(txtUserName.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtUserName, "User Name Is Used Another Person");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtUserName, null);
            }
        }

        private void _ValidatedEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");

            else
                errorProvider1.SetError(Temp, null);
        }

        private void frmAddUpdateUser_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadDataUserInfo();
        }

        private void txtUserName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtUserName.Text))
            {
                _ValidatedEmptyTextBox(sender, e);
                return;
            }

            if (_User != null)
            {
                if (txtUserName.Text != _User.UserName)
                    _ValidateUserName(e);
                return;
            }

            _ValidateUserName(e);
        }

        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            _ValidatedEmptyTextBox(sender, e);
        }

        private void txtConfirmPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                _ValidatedEmptyTextBox(sender, e);
                return;
            }

            if (txtConfirmPassword.Text != txtPassword.Text)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtConfirmPassword, "Password Confirmation Is Not Match Password");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtConfirmPassword, null);
            }
        }

        private void ctrlPersonCardWithFilter1_OnPersonSelected(object sender, ctrlPersonCardWithFilter.PersonSelectedEventArgs e)
        {
            if (e.PersonInfo == null)
            {
                btnSave.Enabled = false;
                return;
            }

            _PersonID = e.PersonInfo.PersonID;
        }

        private void btnNextTab_Click(object sender, EventArgs e)
        {
            if (_Mode == clsEnums.enMode.Update)
            {
                tcUser.SelectedTab = tcUser.TabPages["tpLoginInfo"];
                tpLoginInfo.Enabled = true;
                btnSave.Enabled = true;
                return;
            }

            if (_PersonID != -1)
            {
                if (clsUser.IsExist(_PersonID))
                {
                    MessageBox.Show("Selected Person Already Has A User, Choose Another One.", "Select Another Person", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    ctrlPersonCardWithFilter1.txtFilterValueFocus();
                    return;
                }

                tcUser.SelectedTab = tcUser.TabPages["tpLoginInfo"];
                tpLoginInfo.Enabled = true;
                btnSave.Enabled = true;
                return;
            }

            MessageBox.Show("Please Select A Person,", "Select A Person", MessageBoxButtons.OK, MessageBoxIcon.Error);
            ctrlPersonCardWithFilter1.txtFilterValueFocus();
        }

        private void frmAddUpdateUser_Activated(object sender, EventArgs e)
        {
            ctrlPersonCardWithFilter1.txtFilterValueFocus();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _User.UserName = txtUserName.Text;
            _User.Password = clsUtil.EncryptPassword(txtPassword.Text);
            _User.IsActive = ckbIsActive.Checked;
            _User.PersonID = ctrlPersonCardWithFilter1.PersonID;

            if (_User.Save())
            {
                MessageBox.Show("Data Saved Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                _Mode = clsEnums.enMode.Update;
                lblTitle.Text = "Update User";
                lblUserID.Text = _User.UserID.ToString();

                if (OnAddUpdateUser != null)
                    AddUpdateUser(_User);

                //OnSave?.Invoke();
            }

            else
                MessageBox.Show("Data Saved Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void ckbShowHidePassword_CheckedChanged(object sender, EventArgs e)
        {
            _ShowHidePassword(sender, txtPassword);
        }

        private void ckbShowHideConfirmPassword_CheckedChanged(object sender, EventArgs e)
        {
            _ShowHidePassword(sender, txtConfirmPassword);
        }
    }
}