using System;
using System.Windows.Forms;

namespace CRMS.Make
{
    public partial class frmShowMakeInfo : Form
    {
        public event Action<int> OnMakeChanged;
        protected virtual void MakeChanged(int MakeID)
        {
            Action<int> hander = OnMakeChanged;
            
            if (hander != null)
                hander(MakeID);
        }

        public frmShowMakeInfo(int MakeID)
        {
            InitializeComponent();
            ctrlMakeCard1.LoadMakeInfo(MakeID);
        }

        private void btnClose_Click(object sender, System.EventArgs e) => this.Close();

        private void ctrlMakeCard1_OnMakeChanged(int MakeID)
        {
            if (MakeID == -1)
                return;

            MakeChanged(MakeID);
        }
    }
}