using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRMS.Make
{
    public partial class frmFindMake : Form
    {
        private int _MakeID = -1;

        public event Action<int> OnMakeSelected;
        protected virtual void MakeSelected(int MakeID)
        {
            Action<int> handler = OnMakeSelected;

            if (handler != null)
                handler(MakeID);
        }

        public frmFindMake()
        {
            InitializeComponent();
        }

        private void ctrlMakeCardWithFilter1_OnMakeSelected(object sender, Controls.ctrlMakeCardWithFilter.MakeSelectedEventArgs e)
        {
            if (e.Make == null)
                return;

            _MakeID = e.Make.MakeID;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmFindMake_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (_MakeID == -1)
                return;

            MakeSelected(_MakeID);
        }

        private void frmFindMake_Activated(object sender, EventArgs e)
        {
            ctrlMakeCardWithFilter1.txtValueFilterFocus();
        }
    }
}