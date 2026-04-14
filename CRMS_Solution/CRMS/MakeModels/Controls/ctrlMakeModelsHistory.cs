using CRMS_Business;
using System;
using System.Data;
using System.Windows.Forms;

namespace CRMS.MakeModels.Controls
{
    public partial class ctrlMakeModelsHistory : UserControl
    {
        private int _MakeID = -1;
        private DataTable _dtAllModels = null;
        private DataTable _dtAllModelsWithFilterColumns = null;

        public ctrlMakeModelsHistory()
        {
            InitializeComponent();
        }

        public void txtFilterValueFocus()  => ctrlMakeCardWithFilter1.txtValueFilterFocus();

        private void _LoadModels()
        {
            _dtAllModelsWithFilterColumns = clsMakeModel.GetAllModelsByMakeID(_MakeID);

            if(_dtAllModelsWithFilterColumns == null)
            {
                lblRecordsCount.Text = "[???]";
                return;
            }

            _dtAllModels = _dtAllModelsWithFilterColumns.DefaultView.ToTable(true, "ModelID", "ModelName");

            dgvModels.DataSource = _dtAllModels;
            lblRecordsCount.Text = dgvModels.Rows.Count.ToString();
        }

        public void LoadMakeModelsHistory(int MakeID)
        {
            _MakeID = MakeID;
            ctrlMakeCardWithFilter1.FilterEnabled = false;
            ctrlMakeCardWithFilter1.LoadMakeInfo(_MakeID);
            ctrlMakeCardWithFilter1.SearchPerformClick();

            if (ctrlMakeCardWithFilter1.MakeSelectedInfo == null)
                return;

            _MakeID = ctrlMakeCardWithFilter1.MakeSelectedInfo.MakeID;
            _LoadModels();
        }

        private void ShowModelInfoItem_Click(object sender, EventArgs e)
        {
            if (dgvModels.CurrentCell == null)
                return;

            frmShowModelInfo showModelInfo = new frmShowModelInfo((int)dgvModels.CurrentRow.Cells["ModelID"].Value);
            showModelInfo.OnModelChanged += ShowModelInfo_OnModelChanged;
            showModelInfo.ShowDialog();
        }

        private void ShowModelInfo_OnModelChanged(int ModelID)
        {
            _LoadModels();
        }      
    }
}