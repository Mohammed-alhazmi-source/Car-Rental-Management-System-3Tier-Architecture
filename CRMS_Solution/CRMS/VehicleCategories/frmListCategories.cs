using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.VehicleCategories
{
    public partial class frmListCategories : Form
    {
        private DataTable _dtAllCategories = null;
        private DataView _CategoriesView;


        public frmListCategories()
        {
            InitializeComponent();
        }

        private void _LoadData()
        {
            _dtAllCategories = clsVehicleCategory.GetAllVehicleCategories();

            if (_dtAllCategories == null)
                return;

            _CategoriesView = _dtAllCategories.DefaultView;
            dgvCategories.DataSource = _CategoriesView;
            lblRecordsCount.Text = _CategoriesView.Count.ToString();
        }       

        private void _FilterBy(string ColumnName, Func<string, string> func)
        {
            if (_CategoriesView == null)
                return;

            string Name = func(ColumnName);
            if (string.IsNullOrEmpty(Name) || string.IsNullOrEmpty(txtFilterValue.Text))
            {
                _CategoriesView.RowFilter = "";
                lblRecordsCount.Text = _CategoriesView.Count.ToString();
                return;
            }

            if (Name == CategoryID.Name)
                _CategoriesView.RowFilter = string.Format("[{0}] = {1}", Name, txtFilterValue.Text.Trim());

            else
                _CategoriesView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", Name, txtFilterValue.Text.Trim());

            lblRecordsCount.Text = _CategoriesView.Count.ToString();
        }

        private void frmListCategories_Load(object sender, EventArgs e)
        {
            _LoadData();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("None");
        }

        private void txtFilterValue_TextChanged(object sender, EventArgs e)
        {
            _FilterBy(cbFilterBy.Text, name => name == "Category ID" ? CategoryID.Name : CategoryName.Name);
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbFilterBy.Text == "None")
                txtFilterValue.Visible = false;
            
            else
                txtFilterValue.Visible = true;

            if (_CategoriesView == null)
                return;

            _CategoriesView.RowFilter = "";
            txtFilterValue.Clear();
            lblRecordsCount.Text = _CategoriesView.Count.ToString();
        }

        private void txtFilterValue_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (cbFilterBy.Text == "Category ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;

            else
                e.Handled = (char.IsPunctuation(e.KeyChar) && e.KeyChar != (char)Keys.Back);
        }

        private void btnAddCategory_Click(object sender, EventArgs e)
        {
            frmAddUpdateCategory AddCategory = new frmAddUpdateCategory();
            AddCategory.OnCategoryChanged += AddUpdateCategory_OnCategoryChanged;
            AddCategory.ShowDialog();
        }

        private void AddUpdateCategory_OnCategoryChanged(object sender, frmAddUpdateCategory.AddUpdateEventArgs e)
        {
            if (e.Category == null)
                return;

            _LoadData();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void ShowCategoryInfoItem_Click(object sender, EventArgs e)
        {
            if (dgvCategories.CurrentCell == null)
                return;

            frmShowCategoryInfo showCategoryInfo = new frmShowCategoryInfo((int)dgvCategories.CurrentRow.Cells["CategoryID"].Value);
            showCategoryInfo.OnCategoryChanged += ShowCategoryInfo_OnCategoryChanged; ;
            showCategoryInfo.ShowDialog();
        }

        private void ShowCategoryInfo_OnCategoryChanged(int CategoryID) => _LoadData();

        private void EidtCategoryItem_Click(object sender, EventArgs e)
        {
            if (dgvCategories.CurrentCell == null)
                return;

            frmAddUpdateCategory EditCategory = new frmAddUpdateCategory((int)dgvCategories.CurrentRow.Cells["CategoryID"].Value);
            EditCategory.OnCategoryChanged += AddUpdateCategory_OnCategoryChanged;
            EditCategory.ShowDialog();
        }

        private void DeleteCategoryItem_Click(object sender, EventArgs e)
        {
            if (dgvCategories.CurrentCell == null)
                return;

            if (MessageBox.Show("Are You Sure Delete This Category?", "Confirm", MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Cancel)
                return;

            if (clsVehicleCategory.DeleteCategory((int)dgvCategories.CurrentRow.Cells["CategoryID"].Value))
                MessageBox.Show("Deleted Successfully", "Succussed", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
                MessageBox.Show("Deleted Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}