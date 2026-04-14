using CRMS_Business;
using System;
using System.Windows.Forms;

namespace CRMS.MakeModels.Controls
{
    public partial class ctrlModelCard : UserControl
    {
        private int _ModelID = -1;
        public int ModelID => _ModelID;

        public event Action<int> OnModelChanged;
        protected virtual void ModelChanged(int ModelID)
        {
            Action<int> handler = OnModelChanged;

            if (handler != null)
                handler(ModelID);
        }

        private clsMakeModel _Model = null;
        public clsMakeModel ModelSelectedInfo => _Model;

        private void _ResetDefaultValues()
        {
            llEditModel.Enabled = false;
            lblModelID.Text = "[???]";
            lblModelName.Text = "[???]";
            lblMakeID.Text = "[???]";
            lblMakeName.Text = "[???]";
        }

        private void _FillModelInfoInControls()
        {
            llEditModel.Enabled = true;
            lblModelID.Text = _Model.ModelID.ToString();
            lblModelName.Text = _Model.ModelName;
            lblMakeID.Text = _Model.MakeID.ToString();
            lblMakeName.Text = _Model.MakeInfo.MakeName;
        }

        public void LoadModelInfo(int ModelID)
        {
            _Model = clsMakeModel.Find(ModelID);

            if(_Model == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Model With ID = {ModelID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillModelInfoInControls();
        }

        [Obsolete("This Method Is Not Implemented", true)]
        public void LoadModelInfo(string ModelName)
        {
            _Model = clsMakeModel.Find(0);

            if (_Model == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Model With ID = {ModelID}", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            _FillModelInfoInControls();
        }

        public ctrlModelCard()
        {
            InitializeComponent();
        }

        private void llEditModel_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdateModel EditModel = new frmAddUpdateModel(Convert.ToInt32(lblModelID.Text));
            EditModel.OnModelChanged += AddModel_OnModelChanged;
            EditModel.OnMakeChanged += AddModel_OnModelChanged;
            EditModel.ShowDialog();
        }

        private void AddModel_OnModelChanged(int ModelID)
        {
            LoadModelInfo(ModelID);

            ModelChanged(ModelID);
        }
    }
}