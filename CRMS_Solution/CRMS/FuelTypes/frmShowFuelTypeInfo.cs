using System;
using System.Windows.Forms;

namespace CRMS.FuelTypes
{
    public partial class frmShowFuelTypeInfo : Form
    {
        public event Action<int> OnFuelTypeChanged;
        protected virtual void FuelTypeChanged(int FuelTypeID)
        {
            Action<int> handler = OnFuelTypeChanged;

            if (handler != null)
                handler(FuelTypeID);
        }

        public frmShowFuelTypeInfo(int FuelTypeID)
        {
            InitializeComponent();
            ctrlFuelTypeCard1.LoadFuelTypeInfo(FuelTypeID);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void ctrlFuelTypeCard1_OnFuelTypeChanged(int FuelTypeID) => FuelTypeChanged(FuelTypeID);
    }
}