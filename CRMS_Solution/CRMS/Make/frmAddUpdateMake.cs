using CRMS.GlobalClasses;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.Make
{
    public partial class frmAddUpdateMake : Form
    {
        private clsEnums.enMode _Mode = clsEnums.enMode.Add;
        private int _MakeID = -1;
        private clsMake _Make = null;

        public class MakeEventArgs : EventArgs
        {
            public clsMake Make { get; set; }

            public MakeEventArgs(clsMake make)
            {
                Make = make;
            }
        }

        public event EventHandler<MakeEventArgs> OnMakeChanged;

        private void _MakeChanged(clsMake Make)
        {
            MakeChanged(new MakeEventArgs(Make));
        }

        protected virtual void MakeChanged(MakeEventArgs e)
        {
            OnMakeChanged?.Invoke(this, e);
        }

        public frmAddUpdateMake()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateMake(int MakeID)
        {
            InitializeComponent();
            _MakeID = MakeID;
            _Mode = clsEnums.enMode.Update;
        }

        private void _ResetDefaultValues()
        {
            if (_Mode == clsEnums.enMode.Add)
            {
                lblTitle.Text = "Add New Make";
                lblMakeID.Text = "[???]";
                _Make = new clsMake();
            }
            else
                lblTitle.Text = "Update Make";

            txtMakeName.Text = "";
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtMakeName.Text))
            {
                txtMakeName_Validating(txtMakeName, new CancelEventArgs());
                return false;
            }

            return true;
        }

        private void _LoadMakeInfo()
        {
            _Make = clsMake.Find(_MakeID);

            if(_Make == null)
            {
                MessageBox.Show($"No Make With ID = {_MakeID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblMakeID.Text = _Make.MakeID.ToString();
            txtMakeName.Text = _Make.MakeName;
        }

        private void _ValidateMakeName(CancelEventArgs e)
        {
            if (clsMake.IsExist(txtMakeName.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtMakeName, "The MakeName Is Used Another Make");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtMakeName, null);
            }
        }

        private void frmAddUpdateMake_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadMakeInfo();
        }

        private void txtMakeName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtMakeName.Text))
                errorProvider1.SetError(txtMakeName, "This Filed Is Required");
            else
                errorProvider1.SetError(txtMakeName, null);

            if(_Mode == clsEnums.enMode.Update)
            {
                if (txtMakeName.Text != _Make.MakeName)
                    _ValidateMakeName(e);

                return;
            }

            _ValidateMakeName(e);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _Make.MakeName = txtMakeName.Text.Trim();

            if (_Make.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblMakeID.Text = _Make.MakeID.ToString();
                _Mode = clsEnums.enMode.Update;
                lblTitle.Text = "Update Make";

                if (OnMakeChanged != null)
                    _MakeChanged(_Make);
            }

            else
                MessageBox.Show("Doesn't Saved Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}