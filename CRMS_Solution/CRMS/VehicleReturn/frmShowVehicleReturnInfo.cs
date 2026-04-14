using System.Windows.Forms;

namespace CRMS.VehicleReturn
{
    public partial class frmShowVehicleReturnInfo : Form
    {
        public frmShowVehicleReturnInfo(int BookingID, int ReturnID)
        {
            InitializeComponent();
            ctrlVehicleReturnCard1.LoadVehicleReturnInfo(BookingID, ReturnID);
        }
    }
}