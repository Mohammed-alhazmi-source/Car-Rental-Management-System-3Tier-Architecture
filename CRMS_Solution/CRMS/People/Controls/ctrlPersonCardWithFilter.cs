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

namespace CRMS.People.Controls
{
    public partial class ctrlPersonCardWithFilter : UserControl
    {
        public class PersonSelectedEventArgs : EventArgs
        {
            public clsPerson PersonInfo { get; }

            public PersonSelectedEventArgs(clsPerson personInfo)
            {
                PersonInfo = personInfo;
            }
        }

        public event EventHandler<PersonSelectedEventArgs> OnPersonSelected;

        protected virtual void PersonSelected(clsPerson Person)
        {
            OnPersonSelected?.Invoke(this, new PersonSelectedEventArgs(Person));
        }

        private bool _FilterEnabled = true;
        public bool FilterEnabled
        {
            get { return _FilterEnabled; }
            set
            {
                _FilterEnabled = value;
                gbFilters.Enabled = _FilterEnabled;
            }
        }

        public int PersonID => ctrlPersonCard1.PersonID;

        public clsPerson SelectedPersonInfo => ctrlPersonCard1.SelectedPersonInfo;

        public ctrlPersonCardWithFilter()
        {
            InitializeComponent();
            cbFilterBy.SelectedIndex = 0;
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtValueFilter.Text))
            {
                txtValueFilter_Validating(txtValueFilter, null);
                return false;
            }

            return true;
        }

        public void txtFilterValueFocus()
        {
            txtValueFilter.Focus();
        }

        public void LoadPersonInfo(int PersonID)
        {
            cbFilterBy.SelectedIndex = 1;
            txtValueFilter.Text = PersonID.ToString();
            btnFind.PerformClick();
        }

        public void LoadPersonInfo(string NationalNo)
        {
            cbFilterBy.SelectedIndex = 0;
            txtValueFilter.Text = NationalNo;
            btnFind.PerformClick();
        }

        private void txtValueFilter_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtValueFilter.Text))
                errorProvider1.SetError(txtValueFilter, "This Filed Is Required");

            else
                errorProvider1.SetError(txtValueFilter, null);
        }

        private void txtValueFilter_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
                btnFind.PerformClick();

            if (cbFilterBy.Text == "Person ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            switch (cbFilterBy.Text)
            {
                case "National No.":
                    ctrlPersonCard1.LoadPersonInfo(txtValueFilter.Text.Trim());
                    break;

                case "Person ID":
                    ctrlPersonCard1.LoadPersonInfo(Convert.ToInt32(txtValueFilter.Text.Trim()));
                    break;
            }

            if (OnPersonSelected != null && FilterEnabled)
                PersonSelected(SelectedPersonInfo);
        }

        private void btnAddNewPerson_Click(object sender, EventArgs e)
        {
            frmAddUpdatePerson AddPerson = new frmAddUpdatePerson();
            AddPerson.OnAddUpdatePerson += AddPerson_OnAddUpdatePerson;
            AddPerson.ShowDialog();
        }

        private void AddPerson_OnAddUpdatePerson(object sender, frmAddUpdatePerson.AddUpdatePersonEventArgs e)
        {
            LoadPersonInfo(e.Person.PersonID);
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtValueFilter.Clear();
        }
    }
}