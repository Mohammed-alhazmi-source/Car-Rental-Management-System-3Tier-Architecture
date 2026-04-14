using CRMS_Business;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;

namespace CRMS.Vehicle.Controls
{
    public partial class ctrlVehicleCardWithFilter : UserControl
    {
        private bool _FilterEnabled = true;
        public bool FilterEnabled
        {
            get { return _FilterEnabled; }
            set
            {
                _FilterEnabled = value;
                gbFilters.Enabled = _FilterEnabled;
            }
        }

        private bool _VisibleButtonAddVehicle = true;
        public bool VisibleButtonAddVehicle
        {
            get { return _VisibleButtonAddVehicle; }
            set
            {
                _VisibleButtonAddVehicle = value;
                btnAdd.Visible = _VisibleButtonAddVehicle;
            }
        }

        public clsVehicle VehicleSelectedInfo => ctrlVehicleCard1.VehicleSelectedInfo;

        public class VehicleSelectedEventArgs : EventArgs
        {
            public clsVehicle VehicleInfo { get; set; }

            public VehicleSelectedEventArgs(clsVehicle vehicleInfo)
            {
                VehicleInfo = vehicleInfo;
            }
        }
        public event EventHandler<VehicleSelectedEventArgs> OnVehicleSelected;
        private void _VehicleSelected(clsVehicle VehicleInfo)
        {
            VehicleSelected(new VehicleSelectedEventArgs(VehicleInfo));
        }
        protected virtual void VehicleSelected(VehicleSelectedEventArgs e)
        {
            OnVehicleSelected?.Invoke(this, e);
        }

        public override bool ValidateChildren()
        {
            bool Valid = true;

            if(string.IsNullOrEmpty(txtMakeName.Text))
            {
                txtMakeName_Validating(txtMakeName, new CancelEventArgs());
                Valid = false;
            }
            if(string.IsNullOrEmpty(txtModelName.Text))
            {
                txtModelName_Validating(txtModelName, new CancelEventArgs());
                Valid = false;
            }

            return Valid;
        }      

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");
            else
                errorProvider1.SetError(Temp, null);
        }

        public void LoadVehicleInfo(string MakeName, string ModelName)
        {
            txtMakeName.Text = MakeName;
            txtModelName.Text = ModelName;

            ctrlVehicleCard1.LoadVehicleInfo(MakeName, ModelName);

            if (ctrlVehicleCard1.VehicleID != -1)
                btnFind.PerformClick();
        }

        public ctrlVehicleCardWithFilter()
        {
            InitializeComponent();
        }

        public void txtMakeNameFocus() => txtMakeName.Focus();
        public void txtModelNameFocus() => txtModelName.Focus();

        private void cbtxtModelName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            ctrlVehicleCard1.LoadVehicleInfo(txtMakeName.Text, txtModelName.Text);

            if (OnVehicleSelected != null && FilterEnabled)
                _VehicleSelected(ctrlVehicleCard1.VehicleSelectedInfo);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            frmAddUpdateVehicle AddVehicle = new frmAddUpdateVehicle();
            AddVehicle.OnVehicleSelected += AddVehicle_OnVehicleSelected;
            AddVehicle.ShowDialog();
        }

        private void AddVehicle_OnVehicleSelected(object sender, frmAddUpdateVehicle.VehicleSelectedEventArgs e)
        {
            if (e.VehicleInfo == null)
                return;

            var vehicleInfo = clsVehicle.Find(e.VehicleInfo.VehicleID);

            if (vehicleInfo == null)
                return;

            LoadVehicleInfo(vehicleInfo.MakeInfo.MakeName, vehicleInfo.ModelInfo.ModelName);
        }      

    
        private void txtMakeName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtModelName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtMakeName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            if (e.KeyChar == (char)Keys.Enter)
                btnFind.PerformClick();
        }

        private void txtModelName_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            if (e.KeyChar == (char)Keys.Enter)
                btnFind.PerformClick();
        }
    }
}