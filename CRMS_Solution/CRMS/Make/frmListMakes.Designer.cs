namespace CRMS.Make
{
    partial class frmListMakes
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.label1 = new System.Windows.Forms.Label();
            this.dgvMakes = new System.Windows.Forms.DataGridView();
            this.MakeID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MakeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmsMakes = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowMakeInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.EditMakeItem = new System.Windows.Forms.ToolStripMenuItem();
            this.DeleteMakeItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label2 = new System.Windows.Forms.Label();
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtFilterValue = new System.Windows.Forms.TextBox();
            this.btnAddNewMake = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.ShowMakeModelsHistoryItem = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.dgvMakes)).BeginInit();
            this.cmsMakes.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 25F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(300, 21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(318, 41);
            this.label1.TabIndex = 0;
            this.label1.Text = "Management Makes";
            // 
            // dgvMakes
            // 
            this.dgvMakes.AllowUserToAddRows = false;
            this.dgvMakes.AllowUserToDeleteRows = false;
            this.dgvMakes.AllowUserToOrderColumns = true;
            this.dgvMakes.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 12F);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvMakes.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvMakes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvMakes.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MakeID,
            this.MakeName});
            this.dgvMakes.ContextMenuStrip = this.cmsMakes;
            this.dgvMakes.Location = new System.Drawing.Point(12, 217);
            this.dgvMakes.Name = "dgvMakes";
            this.dgvMakes.ReadOnly = true;
            this.dgvMakes.Size = new System.Drawing.Size(884, 381);
            this.dgvMakes.TabIndex = 1;
            // 
            // MakeID
            // 
            this.MakeID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.MakeID.DataPropertyName = "MakeID";
            this.MakeID.HeaderText = "Make ID";
            this.MakeID.Name = "MakeID";
            this.MakeID.ReadOnly = true;
            // 
            // MakeName
            // 
            this.MakeName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.MakeName.DataPropertyName = "MakeName";
            this.MakeName.HeaderText = "Make Name";
            this.MakeName.Name = "MakeName";
            this.MakeName.ReadOnly = true;
            this.MakeName.Width = 720;
            // 
            // cmsMakes
            // 
            this.cmsMakes.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowMakeInfoItem,
            this.ShowMakeModelsHistoryItem,
            this.toolStripSeparator1,
            this.EditMakeItem,
            this.DeleteMakeItem});
            this.cmsMakes.Name = "cmsMakes";
            this.cmsMakes.Size = new System.Drawing.Size(319, 160);
            // 
            // ShowMakeInfoItem
            // 
            this.ShowMakeInfoItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ShowMakeInfoItem.Name = "ShowMakeInfoItem";
            this.ShowMakeInfoItem.Size = new System.Drawing.Size(318, 32);
            this.ShowMakeInfoItem.Text = "Show Make Info";
            this.ShowMakeInfoItem.Click += new System.EventHandler(this.ShowMakeInfoItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(315, 6);
            // 
            // EditMakeItem
            // 
            this.EditMakeItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.EditMakeItem.Name = "EditMakeItem";
            this.EditMakeItem.Size = new System.Drawing.Size(318, 32);
            this.EditMakeItem.Text = "Edit";
            this.EditMakeItem.Click += new System.EventHandler(this.EditMakeItem_Click);
            // 
            // DeleteMakeItem
            // 
            this.DeleteMakeItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.DeleteMakeItem.Name = "DeleteMakeItem";
            this.DeleteMakeItem.Size = new System.Drawing.Size(318, 32);
            this.DeleteMakeItem.Text = "Delete";
            this.DeleteMakeItem.Click += new System.EventHandler(this.DeleteMakeItem_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(23, 184);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 22);
            this.label2.TabIndex = 2;
            this.label2.Text = "Filter By:";
            // 
            // cbFilterBy
            // 
            this.cbFilterBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFilterBy.Font = new System.Drawing.Font("Tahoma", 13F);
            this.cbFilterBy.FormattingEnabled = true;
            this.cbFilterBy.Items.AddRange(new object[] {
            "None",
            "Make ID",
            "Make Name"});
            this.cbFilterBy.Location = new System.Drawing.Point(109, 181);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(180, 29);
            this.cbFilterBy.TabIndex = 3;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtFilterValue
            // 
            this.txtFilterValue.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFilterValue.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtFilterValue.Location = new System.Drawing.Point(296, 181);
            this.txtFilterValue.Multiline = true;
            this.txtFilterValue.Name = "txtFilterValue";
            this.txtFilterValue.Size = new System.Drawing.Size(247, 29);
            this.txtFilterValue.TabIndex = 4;
            this.txtFilterValue.TextChanged += new System.EventHandler(this.txtFilterValue_TextChanged);
            this.txtFilterValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtFilterValue_KeyPress);
            // 
            // btnAddNewMake
            // 
            this.btnAddNewMake.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddNewMake.Image = global::CRMS.Properties.Resources.add_64px;
            this.btnAddNewMake.Location = new System.Drawing.Point(808, 141);
            this.btnAddNewMake.Name = "btnAddNewMake";
            this.btnAddNewMake.Size = new System.Drawing.Size(88, 69);
            this.btnAddNewMake.TabIndex = 5;
            this.btnAddNewMake.UseVisualStyleBackColor = true;
            this.btnAddNewMake.Click += new System.EventHandler(this.btnAddNewMake_Click);
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(739, 604);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(157, 38);
            this.btnClose.TabIndex = 6;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(23, 604);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(97, 22);
            this.label3.TabIndex = 7;
            this.label3.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblRecordsCount.Location = new System.Drawing.Point(120, 604);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(45, 19);
            this.lblRecordsCount.TabIndex = 8;
            this.lblRecordsCount.Text = "[???]";
            // 
            // ShowMakeModelsHistoryItem
            // 
            this.ShowMakeModelsHistoryItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ShowMakeModelsHistoryItem.Name = "ShowMakeModelsHistoryItem";
            this.ShowMakeModelsHistoryItem.Size = new System.Drawing.Size(318, 32);
            this.ShowMakeModelsHistoryItem.Text = "Show Make Models History";
            this.ShowMakeModelsHistoryItem.Click += new System.EventHandler(this.ShowMakeModelsHistoryItem_Click);
            // 
            // frmListMakes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(919, 665);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnAddNewMake);
            this.Controls.Add(this.txtFilterValue);
            this.Controls.Add(this.cbFilterBy);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvMakes);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmListMakes";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "List Makes";
            this.Load += new System.EventHandler(this.frmListMakes_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvMakes)).EndInit();
            this.cmsMakes.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvMakes;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.TextBox txtFilterValue;
        private System.Windows.Forms.Button btnAddNewMake;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.ContextMenuStrip cmsMakes;
        private System.Windows.Forms.ToolStripMenuItem ShowMakeInfoItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem EditMakeItem;
        private System.Windows.Forms.ToolStripMenuItem DeleteMakeItem;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeID;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeName;
        private System.Windows.Forms.ToolStripMenuItem ShowMakeModelsHistoryItem;
    }
}