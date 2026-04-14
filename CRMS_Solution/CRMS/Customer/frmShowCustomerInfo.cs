using System.Windows.Forms;

namespace CRMS.Customer
{
    public partial class frmShowCustomerInfo : Form
    {
        public frmShowCustomerInfo(int CustomerID)
        {
            InitializeComponent();
            ctrlCustomerCard1.LoadCustomerInfo(CustomerID); 
        }
    }
}