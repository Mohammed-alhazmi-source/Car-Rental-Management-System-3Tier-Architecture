using CRMS.GlobalClasses;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;
using static CRMS.GlobalClasses.clsEnums;

namespace CRMS.VehicleCategories
{
    public partial class frmAddUpdateCategory : Form
    {
        private enMode _Mode = enMode.Add;

        private int _CategoryID = -1;

        private clsVehicleCategory _Category = null;

        public class AddUpdateEventArgs : EventArgs
        {
            public clsVehicleCategory Category { get; set; }

            public AddUpdateEventArgs(clsVehicleCategory category) => Category = category;
        }
        public event EventHandler<AddUpdateEventArgs> OnCategoryChanged;
        private void _RaiseOnCategoryChanged(clsVehicleCategory category)
        {
            RaiseOnCategoryChanged(new AddUpdateEventArgs(category));
        }
        protected virtual void RaiseOnCategoryChanged(AddUpdateEventArgs e)
        {
            OnCategoryChanged?.Invoke(this, e);
        }



        public frmAddUpdateCategory()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdateCategory(int CategoryID)
        {
            InitializeComponent();
            _CategoryID = CategoryID;
            _Mode = clsEnums.enMode.Update;
        }

        private void frmAddUpdateCategory_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == enMode.Update)
                _LoadCategoryInfo();
        }

        private void _ResetDefaultValues()
        {
            if (_Mode == enMode.Add)
            {
                lblTitle.Text = "Add New Category";
                lblCategoryID.Text = "[???]";
                _Category = new clsVehicleCategory();
            }

            else
                lblTitle.Text = "Update Category";

            txtCategoryName.Clear();
        }

        private void _LoadCategoryInfo()
        {
            _Category = clsVehicleCategory.Find(_CategoryID);

            if(_Category == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Category With ID = {_CategoryID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.Close();
                return;
            }

            lblCategoryID.Text = _Category.CategoryID.ToString();
            txtCategoryName.Text = _Category.CategoryName;
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtCategoryName.Text))
            {
                txtCategoryName_Validating(txtCategoryName, new CancelEventArgs());
                return false;
            }

            return true;
        }

        private void _ValidateCategoryName(CancelEventArgs e)
        {
            if(clsVehicleCategory.IsExist(txtCategoryName.Text))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtCategoryName, "The Category Name Is Used Another Category!");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtCategoryName, null);
            }
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtCategoryName.Text))
                errorProvider1.SetError(txtCategoryName, "This Filed Is Required");
            else
                errorProvider1.SetError(txtCategoryName, null);
        }

        private void txtCategoryName_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrEmpty(txtCategoryName.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if(_Mode == enMode.Update)
            {
                if (txtCategoryName.Text != _Category.CategoryName)
                    _ValidateCategoryName(e);
                
                return;
            }

            _ValidateCategoryName(e);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            _Category.CategoryName = txtCategoryName.Text.Trim();

            if (_Category.Save())
            {
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblCategoryID.Text = _Category.CategoryID.ToString();
                lblTitle.Text = "Update Category";
                _Mode = enMode.Update;

                _RaiseOnCategoryChanged(_Category);
            }

            else
                MessageBox.Show("Doesn't Save Data", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}