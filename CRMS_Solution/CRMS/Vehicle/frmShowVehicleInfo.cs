using System;
using System.Windows.Forms;

namespace CRMS.Vehicle
{
    public partial class frmShowVehicleInfo : Form
    {
        private int _VehicleID = -1;

        public event Action<int> OnVehicleChanged;
        protected virtual void VehicleChanged(int VehicleID)
        {
            Action<int> handler = OnVehicleChanged;

            if(handler != null)
                handler(VehicleID);
        }

        public frmShowVehicleInfo(int vehicleID)
        {
            InitializeComponent();
            _VehicleID = vehicleID;
            ctrlVehicleCard1.LoadVehicleInfo(_VehicleID);
        }

        private void ctrlVehicleCard1_OnVehicleChanged(int VehicleID) => VehicleChanged(VehicleID);

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}