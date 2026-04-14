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

namespace CRMS.Customer
{
    public partial class frmListCustomers : Form
    {
        private DataTable _dtAllCustomers = null;
        private DataView _CustomersView;


        public frmListCustomers()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllCustomers = clsCustomer.GetAllCustomers();

            if (_dtAllCustomers == null)
                return;

            _CustomersView = _dtAllCustomers.DefaultView;
            dgvCustomers.DataSource = _CustomersView;
            lblRecordsCount.Text = _CustomersView.Count.ToString();
        }

        private void _FilterBy(string ColumnName)
        {
            if (_CustomersView == null)
                return;

            if (string.IsNullOrEmpty(ColumnName) || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _CustomersView.RowFilter = "";
                lblRecordsCount.Text = _CustomersView.Count.ToString();
                return;
            }

            if (ColumnName == CustomerID.Name || ColumnName == DriverLicenseNumber.Name)
                _CustomersView.RowFilter = string.Format("[{0}] = {1}", ColumnName, txtFilterValue.Text.Trim());

            else
                _CustomersView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", ColumnName, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _CustomersView.Count.ToString();
        }

        private string _GetColumnName()
        {
            switch (cbFilterBy.Text)
            {
                case "Customer ID":           return CustomerID.Name;
                case "Customer Name":         return CustomerName.Name;
                case "Driver License Number": return DriverLicenseNumber.Name;
                case "Phone":                 return Phone.Name;
            }

            return "";
        }

        private void frmListCustomers_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                txtFilterValue.Visible = false;

            else
                txtFilterValue.Visible = true;

            if (_CustomersView == null)
                return;

            _CustomersView.RowFilter = "";
            lblRecordsCount.Text = _CustomersView.Count.ToString();
            txtFilterValue.Clear();
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Customer ID" || cbFilterBy.Text == "Phone" || cbFilterBy.Text == "Driver License Number")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(_GetColumnName());
        }

        private void btnAddCustomer_Click(object sender, EventArgs e)
        {
            frmAddUpdateCustomer addCustomer = new frmAddUpdateCustomer();
            addCustomer.OnSaved += Customer_OnSaved;
            addCustomer.ShowDialog();
        }

        private void Customer_OnSaved(int Customer) => _LoadData();

        private void ShowCustomerInfoItem_Click(object sender, EventArgs e)
        {
            if (dgvCustomers.CurrentCell == null)
                return;

            frmShowCustomerInfo ShowCustomerInfo = new frmShowCustomerInfo((int)dgvCustomers.CurrentRow.Cells["CustomerID"].Value);
            ShowCustomerInfo.ShowDialog();
        }

        private void EditCustomerItem_Click(object sender, EventArgs e)
        {
            if (dgvCustomers.CurrentCell == null)
                return;

            frmAddUpdateCustomer editCustomer = new frmAddUpdateCustomer((int)dgvCustomers.CurrentRow.Cells["CustomerID"].Value);
            editCustomer.OnSaved += Customer_OnSaved;
            editCustomer.ShowDialog();
        }

        private void DeleteCustomerItem_Click(object sender, EventArgs e)
        {
            if (dgvCustomers.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Person?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsCustomer.DeleteCustomer((int)dgvCustomers.CurrentRow.Cells["CustomerID"].Value))
                MessageBox.Show("Deleted Customer Successfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Doesn't Deleted Customer", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void FindCustomerItem_Click(object sender, EventArgs e)
        {
            frmFindCustomer findCustomer = new frmFindCustomer();
            findCustomer.ShowDialog();
        }
    }
}
