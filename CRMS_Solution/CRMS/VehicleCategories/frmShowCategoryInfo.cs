using System;
using System.Windows.Forms;

namespace CRMS.VehicleCategories
{
    public partial class frmShowCategoryInfo : Form
    {
        public event Action<int> OnCategoryChanged;
        protected virtual void RaiseOnCategoryChanged(int CategoryID, Action<int> handler)
        {
            handler?.Invoke(CategoryID);
        }

        public frmShowCategoryInfo(int CategoryID)
        {
            InitializeComponent();
            ctrlCategoryCard1.LoadCategoryInfo(CategoryID);
        }

        private void ctrlCategoryCard1_OnCategoryChanged(int CategoryID)
        {
            RaiseOnCategoryChanged(CategoryID, e => OnCategoryChanged(CategoryID));
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}