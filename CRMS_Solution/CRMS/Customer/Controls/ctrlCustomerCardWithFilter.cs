using CRMS_Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;

namespace CRMS.Customer.Controls
{
    public partial class ctrlCustomerCardWithFilter : UserControl
    {
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

        private DataTable dtCustomers = null;

        public int CustomerID => ctrlCustomerCard1.CustomerID;

        public event Action<int> OnSelectedCustomer;
        protected virtual void SelectedCustomer(int CustomerId)
        {
            Action<int> handler = OnSelectedCustomer;

            if (handler != null)
                handler(CustomerID);
        }

        public clsCustomer CustomerSelectedInfo => ctrlCustomerCard1.CustomerSelectedInfo;

        public void txtFilterValueFocus() => txtFilterValue.Focus();

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtFilterValue.Text))
            {
                txtFilterValue_Validating(txtFilterValue, new CancelEventArgs());
                return false;
            }

            return true;
        }

        public void LoadCustomerInfo(int CustomerID)
        {
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("Customer ID");
            txtFilterValue.Text = CustomerID.ToString();
            btnFind.PerformClick();
        }

        public void LoadCustomerInfo(string CustomerName)
        {
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("Customer Name");
            txtFilterValue.Text = CustomerName;
            btnFind.PerformClick();
       }

        public ctrlCustomerCardWithFilter()
        {
            InitializeComponent();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("Customer Name");
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            frmAddUpdateCustomer AddCustomer = new frmAddUpdateCustomer();
            AddCustomer.OnSaved += AddCustomer_OnSaved;
            AddCustomer.ShowDialog();
        }

        private void AddCustomer_OnSaved(int CustomerID)
        {
            LoadCustomerInfo(CustomerID);
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtFilterValue.Clear();
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            //try
            //{
            //    if (cbFilterBy.Text == "Customer Name")
            //        txtFilterValue.AutoCompleteCustomSource = AutoComplete;
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
        }

        private void txtFilterValue_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtFilterValue.Text))
                errorProvider1.SetError(txtFilterValue, "This Filed Is Required");
            else
                errorProvider1.SetError(txtFilterValue, null);
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
                btnFind.PerformClick();

            if (cbFilterBy.Text == "Customer ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            switch (cbFilterBy.Text)
            {
                case "Customer ID":
                    ctrlCustomerCard1.LoadCustomerInfo(Convert.ToInt32(txtFilterValue.Text.Trim()));
                    break;

                case "Customer Name":
                    ctrlCustomerCard1.LoadCustomerInfo(txtFilterValue.Text.Trim());
                    break;
            }

            if (OnSelectedCustomer != null && FilterEnabled)
                SelectedCustomer(ctrlCustomerCard1.CustomerID);
        }
    }
}