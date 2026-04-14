using System;
using System.Windows.Forms;

namespace CRMS.RentalBooking
{
    public partial class frmShowRentalBookingInfo : Form
    {
        public event Action<int> OnRentalBookingChanged;
        protected virtual void RentalBookingChanged(int RentalBookingID)
        {
            Action<int> handler = OnRentalBookingChanged;

            if(handler != null)
                handler(RentalBookingID);
        }

        public frmShowRentalBookingInfo(int RentalBookingID)
        {
            InitializeComponent();
            ctrlRentalBookingCard1.LoadRentalBookingInfoByID(RentalBookingID);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void ctrlRentalBookingCard1_OnBookingChanged(int RentalBookingID)
        {
            RentalBookingChanged(RentalBookingID);
        }
    }
}