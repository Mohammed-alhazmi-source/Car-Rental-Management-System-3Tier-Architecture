using CRMS.People;
using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.User
{
    public partial class frmListUsers : Form
    {
        private DataView _UsersView;
        private DataTable _dtAllUsers = null;

        public frmListUsers()
        {
            InitializeComponent();
        }

        private void _LoadUsersInfo()
        {
            _dtAllUsers = clsUser.GetAllUsers();

            if (_dtAllUsers == null)
                return;

            _UsersView = _dtAllUsers.DefaultView;
            dgvUsers.DataSource = _UsersView;
            lblRecordsCount.Text = _UsersView.Count.ToString();
        }

        private void _VisibleTextBoxOrComboBox(bool VisibleTextBox, bool VisibleComboBox)
        {
            txtFilterValue.Visible = VisibleTextBox;
            cbFilterByActive.Visible = VisibleComboBox;
        }

        private void _FilterBy(string ColumnName)
        {
            if (_UsersView == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || ColumnName == "" || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _UsersView.RowFilter = "";
                lblRecordsCount.Text = _UsersView.Count.ToString();
                return;
            }

            if (ColumnName == UserID.Name || ColumnName == PersonID.Name)
            {
                _UsersView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());
                lblRecordsCount.Text = _UsersView.Count.ToString();
                return;
            }

            _UsersView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());
            lblRecordsCount.Text = _UsersView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "User ID": return UserID.Name;
                case "Person ID": return PersonID.Name;
                case "Full Name": return FullName.Name;
                case "User Name": return UserName.Name;
            }
            return "";
        }

        private void frmListUsers_Load(object sender, EventArgs e)
        {
            _LoadUsersInfo();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
            cbFilterByActive.SelectedIndex = cbFilterByActive.FindString("All");
        }

        private void OnSave() => _LoadUsersInfo();

        private void btnAddNewUser_Click(object sender, EventArgs e)
        {
            frmAddUpdateUser AddUser = new frmAddUpdateUser();
            AddUser.OnSave += OnSave;
            AddUser.ShowDialog();
        }

        private void ShowPersonDetailsItem_Click(object sender, EventArgs e)
        {
            if (dgvUsers.CurrentCell == null)
                return;

            frmShowPersonInfo showPersonInfo = new frmShowPersonInfo((int)dgvUsers.CurrentRow.Cells["PersonID"].Value);
            showPersonInfo.ShowDialog();
        }

        private void AddNewUserItem_Click(object sender, EventArgs e)
        {
            frmAddUpdateUser AddUser = new frmAddUpdateUser();
            AddUser.OnSave += OnSave;
            AddUser.ShowDialog();
        }

        private void EditUserItem_Click(object sender, EventArgs e)
        {
            if (dgvUsers.CurrentCell == null)
                return;

            frmAddUpdateUser UpdateUser = new frmAddUpdateUser((int)dgvUsers.CurrentRow.Cells["PersonID"].Value);
            UpdateUser.OnSave += OnSave;
            UpdateUser.ShowDialog();
        }

        private void DeleteUserItem_Click(object sender, EventArgs e)
        {
            if (dgvUsers.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure To Delete This User?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2)
                == DialogResult.Cancel)
                return;

            if (clsUser.DeleteUser((int)dgvUsers.CurrentRow.Cells["UserID"].Value))
                MessageBox.Show("Deleted User Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted User Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void ChangePasswordItem_Click(object sender, EventArgs e)
        {
            if (dgvUsers.CurrentCell == null)
                return;

            frmChangePassword changePassword = new frmChangePassword((int)dgvUsers.CurrentRow.Cells["UserID"].Value);
            changePassword.ShowDialog();
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                _VisibleTextBoxOrComboBox(false, false);

            else if (cbFilterBy.Text == "Is Active")
            {
                _VisibleTextBoxOrComboBox(false, true);
                cbFilterByActive.SelectedIndex = cbFilterByActive.FindString("All");
            }
            else
                _VisibleTextBoxOrComboBox(true, false);

            if (_UsersView == null)
                return;

            _UsersView.RowFilter = "";
            lblRecordsCount.Text = _UsersView.Count.ToString();
            txtFilterValue.Clear();
        }

        private void cbFilterByActive_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_UsersView == null)
                return;

            if (cbFilterByActive.Text == "All")
            {
                _UsersView.RowFilter = "";
                lblRecordsCount.Text = _UsersView.Count.ToString();
                return;
            }

            bool Active = (cbFilterByActive.Text == "Yes" ? true : false);
            _UsersView.RowFilter = string.Format("[{0}] = {1}", IsActive.Name, Active);
            lblRecordsCount.Text = _UsersView.Count.ToString();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e) => _FilterBy(_GetColumnName());

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "User ID" || cbFilterBy.Text == "Person ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void ShowUserDetailsItem_Click(object sender, EventArgs e)
        {
            if (dgvUsers.CurrentCell == null)
                return;

            frmShowCurrentUserInfo currentUserInfo = new frmShowCurrentUserInfo((int)dgvUsers.CurrentRow.Cells["UserID"].Value);
            currentUserInfo.ShowDialog();
        }
    }
}