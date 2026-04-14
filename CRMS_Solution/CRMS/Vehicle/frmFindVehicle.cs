using System.Windows.Forms;

namespace CRMS.Vehicle
{
    public partial class frmFindVehicle : Form
    {
        public frmFindVehicle()
        {
            InitializeComponent();
        }

        public frmFindVehicle(string MakeName, string ModelName)
        {
            InitializeComponent();
            ctrlVehicleCardWithFilter1.LoadVehicleInfo(MakeName, ModelName);
        }
    }
}