using System.Windows.Forms;

namespace CRMS.RentalTransaction
{
    public partial class frmShowRentalTransactionInfo : Form
    {
        public frmShowRentalTransactionInfo(int TransactionID)
        {
            InitializeComponent();
            ctrlRentalTransactionCard1.LoadRentalTransactionInfo(TransactionID);
        }
    }
}