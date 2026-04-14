using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.MakeModels.Controls
{
    public partial class ctrlModelCardWithFilter : UserControl
    {
        public class MakeModelSelectedEventArgs : EventArgs
        {
            public clsMakeModel MakeModel { get; set; }

            public MakeModelSelectedEventArgs(clsMakeModel makeModel) => MakeModel = makeModel;
        }
        public event EventHandler<MakeModelSelectedEventArgs> OnMakeModelSelected;
        private void _RaiseOnMakeModelSelected(clsMakeModel MakeModel)
        {
            RaiseOnMakeModelSelected(new MakeModelSelectedEventArgs(MakeModel));
        }
        protected virtual void RaiseOnMakeModelSelected(MakeModelSelectedEventArgs e)
        {
            OnMakeModelSelected?.Invoke(this, e);
        }

        public clsMakeModel MakeModelSelectedInfo => ctrlModelCard1.ModelSelectedInfo;

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

        public void txtMakeNameFocus() => txtMakeName.Focus();

        public void txtModelNameFocus() => txtModelName.Focus();

        public override bool ValidateChildren()
        {
            bool valid = true;

            if(string.IsNullOrEmpty(txtMakeName.Text))
            {
                txtMakeName_Validating(txtMakeName, new CancelEventArgs());
                valid = false;
            }
            if(string.IsNullOrEmpty(txtModelName.Text))
            {
                txtModelName_Validating(txtModelName, new CancelEventArgs());
                valid = false;
            }

            return valid;
        }

        private void _ValidateEmptyTextBox(object sender, CancelEventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");
            else
                errorProvider1.SetError(Temp, null);
        }

        [Obsolete("This Method Is Not Implemented", true)]
        public void LoadMakeModelInfo(string MakeName, string ModelName)
        {
        }

        public ctrlModelCardWithFilter()
        {
            InitializeComponent();
        }

        private void txtMakeName_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);

        private void txtModelName_Validating(object sender, CancelEventArgs e) => _ValidateEmptyTextBox(sender, e);
    }
}