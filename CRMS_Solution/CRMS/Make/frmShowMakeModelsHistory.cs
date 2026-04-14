using System.Windows.Forms;

namespace CRMS.Make
{
    public partial class frmShowMakeModelsHistory : Form
    {
        public frmShowMakeModelsHistory(int MakeID)
        {
            InitializeComponent();
            ctrlMakeModelsHistory1.LoadMakeModelsHistory(MakeID);
        }

        private void frmShowMakeModelsHistory_Activated(object sender, System.EventArgs e)
        {
            //ctrlMakeModelsHistory1.txtFilterValueFocus();
        }
    }
}