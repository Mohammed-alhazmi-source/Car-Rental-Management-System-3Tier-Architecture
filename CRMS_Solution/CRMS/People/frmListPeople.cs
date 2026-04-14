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

namespace CRMS.People
{
    public partial class frmListPeople : Form
    {
        public event Action<int> DataBack;
        private DataView _PeopleView;
        private DataTable _dtPeople = null;

        private void _LoadData()
        {
            _dtPeople = clsPerson.GetAllPeople();

            if (_dtPeople == null)
                return;

            _PeopleView = _dtPeople.DefaultView;
            dgvPeople.DataSource = _PeopleView;
        }

        private void _FilterBy(string ColumnName)
        {
            if (_PeopleView == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || ColumnName == "None" || string.IsNullOrEmpty(txtValueFilter.Text))
            {
                _PeopleView.RowFilter = "";
                lblRecordsCount.Text = _PeopleView.Count.ToString();
                return;
            }

            if (ColumnName == PersonID.Name)
            {
                _PeopleView.RowFilter = string.Format("[{0}] = {1}", ColumnName, Convert.ToInt32(txtValueFilter.Text.Trim()));
                lblRecordsCount.Text = _PeopleView.Count.ToString();
                return;
            }

            _PeopleView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtValueFilter.Text.Trim());
            lblRecordsCount.Text = _PeopleView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "None": return "";
                case "Person ID": return PersonID.Name;
                case "Full Name": return FullName.Name;
                case "Gender": return Gender.Name;
                case "National No.": return NationalNo.Name;
                case "Nationality": return Nationality.Name;
                case "Phone": return Phone.Name;
                case "Email": return Email.Name;
            }

            return "";
        }

        public frmListPeople()
        {
            InitializeComponent();
        }

        private void frmListPeople_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = 0;

            if (_PeopleView == null)
                return;

            lblRecordsCount.Text = _PeopleView.Count.ToString();
        }

        private void btnAddNewPerson_Click(object sender, EventArgs e)
        {
            frmAddUpdatePerson addUpdatePerson = new frmAddUpdatePerson();
            addUpdatePerson.OnAddUpdatePerson += AddUpdatePerson_DataBack;
            addUpdatePerson.ShowDialog();
        }

        private void AddUpdatePerson_DataBack(object sender, frmAddUpdatePerson.AddUpdatePersonEventArgs e)
        {
            _LoadData();
        }

        private void ShowPersonDetailsItem_Click(object sender, EventArgs e)
        {
            if (dgvPeople.CurrentCell == null)
                return;

            frmShowPersonInfo showPersonInfo = new frmShowPersonInfo((int)dgvPeople.CurrentRow.Cells["PersonID"].Value);
            showPersonInfo.ShowDialog();
        }

        private void AddNewPersonItem_Click(object sender, EventArgs e)
        {
            frmAddUpdatePerson AddPerson = new frmAddUpdatePerson();
            AddPerson.OnAddUpdatePerson += AddUpdatePerson_DataBack;
            AddPerson.ShowDialog();
        }

        private void EditPersonItem_Click(object sender, EventArgs e)
        {
            if (dgvPeople.CurrentCell == null)
                return;

            frmAddUpdatePerson UpdatePerson = new frmAddUpdatePerson((int)dgvPeople.CurrentRow.Cells["PersonID"].Value);
            UpdatePerson.OnAddUpdatePerson += AddUpdatePerson_DataBack;
            UpdatePerson.ShowDialog();
        }

        private void DeletePersonItem_Click(object sender, EventArgs e)
        {
            if (dgvPeople.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Person?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsPerson.DeletePerson((int)dgvPeople.CurrentRow.Cells["PersonID"].Value))
                MessageBox.Show("Deleted Successfully", "Succussed", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
            {
                txtValueFilter.Visible = false;

                if (_PeopleView == null)
                    return;

                _PeopleView.RowFilter = "";
                lblRecordsCount.Text = _PeopleView.Count.ToString();
                return;
            }

            txtValueFilter.Visible = true;

            if (_PeopleView == null)
                return;

            _PeopleView.RowFilter = "";
            lblRecordsCount.Text = _PeopleView.Count.ToString();
            txtValueFilter.Clear();
        }

        private void txtValueFilter_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void txtValueFilter_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Person ID" || cbFilterBy.Text == "Phone")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnClose_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
