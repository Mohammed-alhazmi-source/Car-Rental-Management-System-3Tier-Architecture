using CRMS_Business;
using System;
using System.Windows.Forms;

namespace CRMS.VehicleCategories.Controls
{
    public partial class ctrlCategoryCard : UserControl
    {
        private int _CategoryID = -1;
        public int CategoryID => _CategoryID;

        private clsVehicleCategory _Category = null;
        public clsVehicleCategory CategorySelectedInfo => _Category;

        public event Action<int> OnCategoryChanged;
        protected virtual void CategoryChanged(int CategoryID)
        {
            Action<int> handler = OnCategoryChanged;

            if (handler != null)
                handler(CategoryID);
        }

        private void _ResetDefaultValues()
        {
            llEditCategoryInfo.Enabled = false;
            lblCategoryID.Text = "[???]";
            lblCategoryName.Text = "[???]";
        }

        private void _FillCategoryInfoInControls()
        {
            llEditCategoryInfo.Enabled = true;
            _CategoryID = _Category.CategoryID;
            lblCategoryID.Text = _Category.CategoryID.ToString();
            lblCategoryName.Text = _Category.CategoryName;
        }

        public void LoadCategoryInfo(int CategoryID)
        {
            _Category = clsVehicleCategory.Find(CategoryID);

            if(_Category == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Category With ID = {CategoryID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillCategoryInfoInControls();
        }

        public void LoadCategoryInfo(string CategoryName)
        {
            _Category = clsVehicleCategory.Find(CategoryName);

            if (_Category == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Category With Name = {CategoryName}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillCategoryInfoInControls();
        }

        public ctrlCategoryCard()
        {
            InitializeComponent();
        }

        private void llEditCategoryInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateCategory EditCategory = new frmAddUpdateCategory(Convert.ToInt32(lblCategoryID.Text));
            EditCategory.OnCategoryChanged += EditCategory_OnCategoryChanged;
            EditCategory.ShowDialog();
        }

        private void EditCategory_OnCategoryChanged(object sender, frmAddUpdateCategory.AddUpdateEventArgs e)
        {
            if (e.Category == null)
                return;

            LoadCategoryInfo(e.Category.CategoryID);

            CategoryChanged(e.Category.CategoryID);
        }
    }
}