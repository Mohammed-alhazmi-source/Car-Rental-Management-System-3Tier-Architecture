using CRMS_Business;
using System.Windows.Forms;

namespace CRMS.Customer.Controls
{
    public partial class ctrlCustomerCard : UserControl
    {
        private int _CustomerID = -1;
        public int CustomerID => _CustomerID;

        private clsCustomer _Customer = null;
        public clsCustomer CustomerSelectedInfo => _Customer;

        public ctrlCustomerCard() => InitializeComponent();

        private void _ResetDefaultValues()
        {
            llEditCustomerInfo.Enabled = false;
            lblCustomerID.Text = "[???]";
            lblCustomerName.Text = "[???]";
            lblDriverLicenseNumber.Text = "[???]";
            lblPhone.Text = "[???]";
            lblCreatedBy.Text = "[???]";
        }

        private void _FillCustomerDataInControls()
        {
            llEditCustomerInfo.Enabled = true;
            _CustomerID = _Customer.CustomerID;
            lblCustomerID.Text = _Customer.CustomerID.ToString();
            lblCustomerName.Text = _Customer.CustomerName;
            lblDriverLicenseNumber.Text = _Customer.DriverLicenseNumber.ToString();
            lblPhone.Text = _Customer.Phone;
            lblCreatedBy.Text = _Customer.CreatedByUserID.ToString();
        }

        public void LoadCustomerInfo(int CustomerID)
        {
            _Customer = clsCustomer.Find(CustomerID);

            if(_Customer == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Customer With ID = {CustomerID}", "No Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                _CustomerID = -1;
                return;
            }

            _FillCustomerDataInControls();
        }

        public void LoadCustomerInfo(string CustomerName)
        {
            _Customer = clsCustomer.Find(CustomerName);

            if (_Customer == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Customer With Name = {CustomerName}", "No Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                _CustomerID = -1;
                return;
            }

            _FillCustomerDataInControls();
        }

        private void llEditCustomerInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            if(int.TryParse(lblCustomerID.Text, out int CustomerID))
            {
                frmAddUpdateCustomer EditCustomer = new frmAddUpdateCustomer(CustomerID);
                EditCustomer.OnSaved += EditCustomer_OnSaved;
                EditCustomer.ShowDialog();
            }
        }

        private void EditCustomer_OnSaved(int CustomerID) => LoadCustomerInfo(CustomerID);
    }
}