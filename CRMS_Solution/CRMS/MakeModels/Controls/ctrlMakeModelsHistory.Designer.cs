namespace CRMS.MakeModels.Controls
{
    partial class ctrlMakeModelsHistory
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dgvModels = new System.Windows.Forms.DataGridView();
            this.ModelID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ModelName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmsMakeModels = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowModelInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label1 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.ctrlMakeCardWithFilter1 = new CRMS.Make.Controls.ctrlMakeCardWithFilter();
            ((System.ComponentModel.ISupportInitialize)(this.dgvModels)).BeginInit();
            this.cmsMakeModels.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgvModels
            // 
            this.dgvModels.AllowUserToAddRows = false;
            this.dgvModels.AllowUserToDeleteRows = false;
            this.dgvModels.AllowUserToOrderColumns = true;
            this.dgvModels.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Bold);
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvModels.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvModels.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvModels.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ModelID,
            this.ModelName});
            this.dgvModels.ContextMenuStrip = this.cmsMakeModels;
            this.dgvModels.Location = new System.Drawing.Point(42, 254);
            this.dgvModels.Name = "dgvModels";
            this.dgvModels.ReadOnly = true;
            this.dgvModels.Size = new System.Drawing.Size(980, 322);
            this.dgvModels.TabIndex = 2;
            // 
            // ModelID
            // 
            this.ModelID.DataPropertyName = "ModelID";
            this.ModelID.HeaderText = "Model ID";
            this.ModelID.Name = "ModelID";
            this.ModelID.ReadOnly = true;
            // 
            // ModelName
            // 
            this.ModelName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.ModelName.DataPropertyName = "ModelName";
            this.ModelName.HeaderText = "Model Name";
            this.ModelName.Name = "ModelName";
            this.ModelName.ReadOnly = true;
            this.ModelName.Width = 820;
            // 
            // cmsMakeModels
            // 
            this.cmsMakeModels.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowModelInfoItem});
            this.cmsMakeModels.Name = "cmsMakeModels";
            this.cmsMakeModels.Size = new System.Drawing.Size(229, 36);
            // 
            // ShowModelInfoItem
            // 
            this.ShowModelInfoItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ShowModelInfoItem.Name = "ShowModelInfoItem";
            this.ShowModelInfoItem.Size = new System.Drawing.Size(228, 32);
            this.ShowModelInfoItem.Text = "Show Model Info";
            this.ShowModelInfoItem.Click += new System.EventHandler(this.ShowModelInfoItem_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label1.Location = new System.Drawing.Point(47, 579);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(97, 22);
            this.label1.TabIndex = 4;
            this.label1.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblRecordsCount.Location = new System.Drawing.Point(142, 581);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(45, 19);
            this.lblRecordsCount.TabIndex = 5;
            this.lblRecordsCount.Text = "[???]";
            // 
            // ctrlMakeCardWithFilter1
            // 
            this.ctrlMakeCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCardWithFilter1.FilterEnabled = true;
            this.ctrlMakeCardWithFilter1.Location = new System.Drawing.Point(136, 0);
            this.ctrlMakeCardWithFilter1.Name = "ctrlMakeCardWithFilter1";
            this.ctrlMakeCardWithFilter1.Size = new System.Drawing.Size(778, 253);
            this.ctrlMakeCardWithFilter1.TabIndex = 6;
            // 
            // ctrlMakeModelsHistory
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.ctrlMakeCardWithFilter1);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgvModels);
            this.Name = "ctrlMakeModelsHistory";
            this.Size = new System.Drawing.Size(1064, 610);
            ((System.ComponentModel.ISupportInitialize)(this.dgvModels)).EndInit();
            this.cmsMakeModels.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DataGridView dgvModels;
        private System.Windows.Forms.ContextMenuStrip cmsMakeModels;
        private System.Windows.Forms.ToolStripMenuItem ShowModelInfoItem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelID;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelName;
        private Make.Controls.ctrlMakeCardWithFilter ctrlMakeCardWithFilter1;
    }
}
