using CRMS_Business;
using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace CRMS.Make.Controls
{
    public partial class ctrlMakeCardWithFilter : UserControl
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

        public event Action<int> OnMakeChanged;
        protected virtual void MakeChanged(int MakeID)
        {
            Action<int> handler = OnMakeChanged;

            if (handler != null)
                handler(MakeID);
        }

        public class MakeSelectedEventArgs: EventArgs
        {
            public clsMake Make { get; set; }

            public MakeSelectedEventArgs(clsMake Make)
            {
                this.Make = Make;
            }
        }

        public event EventHandler<MakeSelectedEventArgs> OnMakeSelected;             
        private void _MakeSelected(clsMake Make)
        {
            MakeSelected(new MakeSelectedEventArgs(Make));
        }
        protected virtual void MakeSelected(MakeSelectedEventArgs e)
        {
            OnMakeSelected?.Invoke(this, e);
        }

        delegate Button InvokeDel(object sender, EventArgs e);

        public int MakeID => ctrlMakeCard1.MakeID;

        public clsMake MakeSelectedInfo => ctrlMakeCard1.MakeSelectedInfo;

        public void txtValueFilterFocus()
        {
            txtValueFilter.Focus();
            //SearchPerformClick();
        }

        public void SearchPerformClick()
        {
            btnSearch_Click(null, null);
        }

        public override bool ValidateChildren()
        {
            if(string.IsNullOrEmpty(txtValueFilter.Text))
            {
                txtValueFilter_Validating(txtValueFilter, new CancelEventArgs());
                return false;
            }

            return true;
        }

        public void LoadMakeInfo(int MakeID)
        {
            cbFilterBy.SelectedIndex = 1;
            txtValueFilter.Text = MakeID.ToString();
            SearchPerformClick();
        }

        public void LoadMakeInfo(string MakeName)
        {
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("Make Name");
            txtValueFilter.Text = MakeName;
            SearchPerformClick();
        }

        public ctrlMakeCardWithFilter()
        {
            InitializeComponent();
            cbFilterBy.SelectedIndex = cbFilterBy.FindString("Make Name");
        }

     
        private void AddMake_OnMakeChanged(object sender, frmAddUpdateMake.MakeEventArgs e)
        {
            if (e.Make == null)
            {
                LoadMakeInfo(-1);
                return;
            }

            LoadMakeInfo(e.Make.MakeID);
        }

        private void ctrlMakeCard1_OnMakeChanged(int MakeId)
        {
            MakeChanged(MakeId);
        }

        private void btnAddNewMake_Click(object sender, EventArgs e)
        {
            frmAddUpdateMake AddMake = new frmAddUpdateMake();
            AddMake.OnMakeChanged += AddMake_OnMakeChanged;
            AddMake.ShowDialog();
        }

        private void txtValueFilter_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
                SearchPerformClick();

            if (cbFilterBy.Text == "Make ID")
                e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void txtValueFilter_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtValueFilter.Text))
                errorProvider1.SetError(txtValueFilter, "This Filed Is Required");

            else
                errorProvider1.SetError(txtValueFilter, null);
        }

        private void cbFilterBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtValueFilter.Text = "";
        }
    
        private void btnSearch_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
                return;

            switch (cbFilterBy.Text)
            {
                case "Make Name":
                    ctrlMakeCard1.LoadMakeInfo(txtValueFilter.Text.Trim());
                    break;

                case "Make ID":
                    ctrlMakeCard1.LoadMakeInfo(Convert.ToInt32(txtValueFilter.Text.Trim()));
                    break;
            }

            if (OnMakeSelected != null && FilterEnabled)
                _MakeSelected(MakeSelectedInfo);
        }
    }
}