using CRMS.GlobalClasses;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.User
{
    public partial class frmChangePassword : Form
    {
        private int _UserID = -1;

        public frmChangePassword(int UserID)
        {
            InitializeComponent();
            _UserID = UserID;
        }

        private void _ResetDefaultValues()
        {
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        private void _ShowHidePassword(CheckBox CurrentChecked, TextBox CurrentTextBox)
        {
            if (CurrentChecked.Checked)
            {
                CurrentChecked.Text = "Hide";
                CurrentTextBox.PasswordChar = '\0';
            }
            else
            {
                CurrentChecked.Text = "Show";
                CurrentTextBox.PasswordChar = '*';
            }
        }

        public override bool ValidateChildren()
        {
            bool IsValid = true;

            if (string.IsNullOrEmpty(txtCurrentPassword.Text))
            {
                txtCurrentPassword_Validating(txtCurrentPassword, null);
                IsValid = false;
            }
            if (string.IsNullOrEmpty(txtNewPassword.Text))
            {
                txtNewPassword_Validating(txtNewPassword, null);
                IsValid = false;
            }
            if (string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                txtConfirmPassword_Validating(txtConfirmPassword, null);
                IsValid = false;
            }

            return IsValid;
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");

            else
                errorProvider1.SetError(Temp, null);
        }

        private void frmChangePassword_Load(object sender, EventArgs e)
        {
            ctrlUserCard1.LoadUserInfoByUserID(_UserID);
            _ResetDefaultValues();
        }

        private void frmChangePassword_Activated(object sender, EventArgs e) => txtCurrentPassword.Focus();

        private void txtCurrentPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtCurrentPassword.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if (txtCurrentPassword.Text != clsUtil.DecryptPassword(clsGlobal.CurrentUser.Password))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtCurrentPassword, "Current Password Is Wrong");
            }

            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtCurrentPassword, null);
            }
        }

        private void txtNewPassword_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtConfirmPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if (txtConfirmPassword.Text != txtNewPassword.Text)
            {
                e.Cancel = true;
                errorProvider1.SetError(txtConfirmPassword, "Password Confirmation Doesn't Match Password");
            }

            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtConfirmPassword, null);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            ctrlUserCard1.SelectedUserInfo.Password = clsUtil.EncryptPassword(txtNewPassword.Text);

            if (ctrlUserCard1.SelectedUserInfo.Save())
            {
                MessageBox.Show("Change Password Successfully", "Changed", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtCurrentPassword.Clear();
                txtNewPassword.Clear();
                txtConfirmPassword.Clear();
            }
            else
                MessageBox.Show("Change Password Failed", "No Changed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void ckbShowHideCurrentPassword_CheckedChanged(object sender, EventArgs e)
        {
            _ShowHidePassword(ckbShowHideCurrentPassword, txtCurrentPassword);
        }

        private void ckbShowHideNewPassword_CheckedChanged(object sender, EventArgs e)
        {
            _ShowHidePassword(ckbShowHideNewPassword, txtNewPassword);
        }

        private void ckbShowHideConfirmPassword_CheckedChanged(object sender, EventArgs e)
        {
            _ShowHidePassword(ckbShowHideConfirmPassword, txtConfirmPassword);
        }
    }
}