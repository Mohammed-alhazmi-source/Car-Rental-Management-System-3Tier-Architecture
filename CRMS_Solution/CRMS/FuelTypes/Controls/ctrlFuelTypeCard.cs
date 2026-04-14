using CRMS_Business;
using System;
using System.Windows.Forms;

namespace CRMS.FuelTypes.Controls
{
    public partial class ctrlFuelTypeCard : UserControl
    {
        private int _FuelTypeID = -1;
        public int FuelTypeID => _FuelTypeID;

        public event Action<int> OnFuelTypeChanged;
        protected virtual void FuelTypeChanged(int FuelTypeID)
        {
            Action<int> handler = OnFuelTypeChanged;

            if (handler != null)
                handler(FuelTypeID);
        }

        private clsFuelType _FuelType = null;
        public clsFuelType FuelTypeSelectedInfo => _FuelType;

        private void _ResetDefaultValues()
        {
            llEditFuelTypeInfo.Enabled = false;
            lblFuelTypeID.Text = "[???]";
            lblFuelType.Text = "[???]";
        }

        private void _FillFuelTypeInfoInControls()
        {
            llEditFuelTypeInfo.Enabled = true;
            lblFuelTypeID.Text = _FuelType.FuelTypeID.ToString();
            lblFuelType.Text = _FuelType.FuelType;
        }

        public void LoadFuelTypeInfo(int FuelTypeID)
        {
            _FuelType = clsFuelType.Find(FuelTypeID);

            if(_FuelType == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Fuel Type With ID = {FuelTypeID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillFuelTypeInfoInControls();
        }

        public ctrlFuelTypeCard()
        {
            InitializeComponent();
        }

        private void llEditFuelTypeInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateFuelType EditFuelType = new frmAddUpdateFuelType(Convert.ToInt32(lblFuelTypeID.Text));
            EditFuelType.OnAddUpdateFuelType += EditFuelType_OnAddUpdateFuelType;
            EditFuelType.ShowDialog();
        }

        private void EditFuelType_OnAddUpdateFuelType(int FuelTypeID)
        {
            LoadFuelTypeInfo(FuelTypeID);

            FuelTypeChanged(FuelTypeID);
        }
    }
}