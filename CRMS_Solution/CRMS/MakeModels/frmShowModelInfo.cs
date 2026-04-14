using System;
using System.Windows.Forms;

namespace CRMS.MakeModels
{
    public partial class frmShowModelInfo : Form
    {
        public event Action<int> OnModelChanged;
        protected virtual void ModelChanged(int ModelID)
        {
            Action<int> handler = OnModelChanged;

            if (handler != null)
                handler(ModelID);
        }

        private int _ModelID = -1;

        public frmShowModelInfo(int ModelID)
        {
            InitializeComponent();
            _ModelID = ModelID;
            ctrlModelCard1.LoadModelInfo(_ModelID);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();

        private void frmShowModelInfo_FormClosing(object sender, FormClosingEventArgs e)
        {
            ModelChanged(_ModelID);
        }

        private void ctrlModelCard1_OnModelChanged(int ModelID)
        {
            _ModelID = ModelID;
        }
    }
}