using System.Windows.Forms;

namespace CRMS.Customer
{
    public partial class frmFindCustomer : Form
    {        
        public frmFindCustomer()
        {
            InitializeComponent();
        }

        private void frmFindCustomer_Activated(object sender, System.EventArgs e)
        {
            ctrlCustomerCardWithFilter1.txtFilterValueFocus();
        }
    }
}