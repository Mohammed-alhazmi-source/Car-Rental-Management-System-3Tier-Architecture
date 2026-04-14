using CRMS_Business;
using System;
using System.Windows.Forms;

namespace CRMS.Make.Controls
{
    public partial class ctrlMakeCard : UserControl
    {
        private int _MakeID = -1;
        public int MakeID => _MakeID;

        private clsMake _Make = null;
        public clsMake MakeSelectedInfo => _Make;

        public event Action<int> OnMakeChanged;
        protected virtual void MakeChanged(int MakeID)
        {
            Action<int> handler = OnMakeChanged;

            if (handler != null)
                handler(MakeID);
        }

        private void _ResetDefaultValues()
        {
            llEditMakeInfo.Enabled = false;
            lblMakeID.Text = "[???]";
            lblMakeName.Text = "[???]";
        }

        private void _FillMakeInfoInControls()
        {
            llEditMakeInfo.Enabled = true;
            _MakeID = _Make.MakeID;
            lblMakeID.Text = _Make.MakeID.ToString();
            lblMakeName.Text = _Make.MakeName;
        }

        public void LoadMakeInfo(int MakeID)
        {
            _Make = clsMake.Find(MakeID);

            if(_Make == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Make With ID = {MakeID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillMakeInfoInControls();
        }

        public void LoadMakeInfo(string MakeName)
        {
            _Make = clsMake.Find(MakeName);

            if (_Make == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Make With Name = {MakeName}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillMakeInfoInControls();
        }

        public ctrlMakeCard()
        {
            InitializeComponent();
        }

        private void llEditMakeInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateMake EditMake = new frmAddUpdateMake(Convert.ToInt32(lblMakeID.Text));
            EditMake.OnMakeChanged += EditMake_OnMakeChanged;
            EditMake.ShowDialog();
        }

        private void EditMake_OnMakeChanged(object sender, frmAddUpdateMake.MakeEventArgs e)
        {
            if (e.Make == null)
                return;

            LoadMakeInfo(e.Make.MakeID);

            MakeChanged(e.Make.MakeID);
        }
    }
}