using CRMS.GlobalClasses;
using CRMS.Make.Controls;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.MakeModels
{
    public partial class frmAddUpdateModel : Form
    {
        private clsEnums.enMode _Mode = clsEnums.enMode.Add;

        private int _ModelID = -1;
        private int _MakeID = -1;

        private clsMakeModel _Model = null;

        public event Action<int> OnModelChanged;
        protected virtual void ModelChanged(int ModelID)
        {
            Action<int> handler = OnModelChanged;

            if (handler != null)
                handler(ModelID);
        }

        public event Action<int> OnMakeChanged;
        protected virtual void MakeChanged(int MakeID)
        {
            Action<int> handler = OnMakeChanged;

            if (handler != null)
                handler(MakeID);
        }

        public frmAddUpdateModel()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateModel(int ModelID)
        {
            InitializeComponent();
            _ModelID = ModelID;
            _Mode = clsEnums.enMode.Update;
        }

        private void frmAddUpdateModel_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadModelInfo();
        }

        private void _ResetDefaultValues()
        {
            tpModelInfo.Enabled = false;

            if (_Mode == clsEnums.enMode.Add)
            {
                lblModelID.Text = "[???]";
                lblTitle.Text = "Add New Model";
                _Model = new clsMakeModel();
            }
            else
                lblTitle.Text = "Update Model";

            txtModelName.Text = "";
            txtModelName.Focus();
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtModelName.Text))
            {
                txtModelName_Validating(txtModelName, new CancelEventArgs());
                return false;
            }

            return true;
        }

        private void _LoadModelInfo()
        {
            _Model = clsMakeModel.Find(_ModelID);

            if(_Model == null)
            {
                MessageBox.Show("Not Found Model With ID = " + _ModelID, "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            ctrlMakeCardWithFilter1.LoadMakeInfo(_Model.MakeID);
            ctrlMakeCardWithFilter1.FilterEnabled = false;
            ctrlMakeCardWithFilter1.SearchPerformClick();
            lblModelID.Text = _Model.ModelID.ToString();
            txtModelName.Text = _Model.ModelName;
        }

        private void _ValidateModelName(CancelEventArgs e)
        {
            if(clsMakeModel.IsExist(txtModelName.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtModelName, "The Model Name Is Used Another Model");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtModelName, null);
            }
        }

        private void txtModelName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtModelName.Text))
                errorProvider1.SetError(txtModelName, "This Filed Is Required");
            
            else
                errorProvider1.SetError(txtModelName, null);

            if(_Mode == clsEnums.enMode.Update)
            {
                if (txtModelName.Text != _Model.ModelName)
                    _ValidateModelName(e);

                return;
            }

            // Add Mode
            _ValidateModelName(e);
        }

        private void btnNextTab_Click(object sender, EventArgs e)
        {
            if(_Mode == clsEnums.enMode.Update)
            {
                tpModelInfo.Enabled = true;
                tcModel.SelectedTab = tcModel.TabPages["tpModelInfo"];
                btnSave.Enabled = true;
                txtModelName.Focus();
                return;
            }

            if(_MakeID != -1)
            {
                tpModelInfo.Enabled = true;
                tcModel.SelectedTab = tcModel.TabPages["tpModelInfo"];
                btnSave.Enabled = true;
                txtModelName.Focus();
                return;
            }

            MessageBox.Show("Please Select A Make,", "Select A Make", MessageBoxButtons.OK, MessageBoxIcon.Error);
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }

        private void ctrlMakeCardWithFilter1_OnMakeSelected(object sender, ctrlMakeCardWithFilter.MakeSelectedEventArgs e)
        {
            if(e.Make == null)
            {
                btnSave.Enabled = false;
                return;
            }

            _MakeID = e.Make.MakeID;
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _Model.MakeID = ctrlMakeCardWithFilter1.MakeID;
            _Model.ModelName = txtModelName.Text.Trim();

            if (_Model.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblModelID.Text = _Model.ModelID.ToString();
                lblTitle.Text = "Update Model";
                _Mode = clsEnums.enMode.Update;

                ModelChanged(_Model.ModelID);
            }
            else
                MessageBox.Show("Doesn't Save Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void ctrlMakeCardWithFilter1_OnMakeChanged(int MakeID)
        {
            MakeChanged(MakeID);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void frmAddUpdateModel_Activated(object sender, EventArgs e)
        {
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }
    }
}