namespace CRMS.FuelTypes
{
    partial class frmListFuelTypes
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.label1 = new System.Windows.Forms.Label();
            this.dgvFuelTypes = new System.Windows.Forms.DataGridView();
            this.FuelTypeID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FuelType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label2 = new System.Windows.Forms.Label();
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtFilterValue = new System.Windows.Forms.TextBox();
            this.btnAddFuelType = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.cmsFuelTypes = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowFuelTypeInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.EditFuelTypeItem = new System.Windows.Forms.ToolStripMenuItem();
            this.DeleteFuelTypeItem = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFuelTypes)).BeginInit();
            this.cmsFuelTypes.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 25F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(208, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(387, 41);
            this.label1.TabIndex = 0;
            this.label1.Text = "Management Fuel Types";
            // 
            // dgvFuelTypes
            // 
            this.dgvFuelTypes.AllowUserToAddRows = false;
            this.dgvFuelTypes.AllowUserToDeleteRows = false;
            this.dgvFuelTypes.AllowUserToOrderColumns = true;
            this.dgvFuelTypes.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 9F);
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvFuelTypes.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvFuelTypes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvFuelTypes.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.FuelTypeID,
            this.FuelType});
            this.dgvFuelTypes.ContextMenuStrip = this.cmsFuelTypes;
            this.dgvFuelTypes.Location = new System.Drawing.Point(12, 147);
            this.dgvFuelTypes.Name = "dgvFuelTypes";
            this.dgvFuelTypes.ReadOnly = true;
            this.dgvFuelTypes.Size = new System.Drawing.Size(776, 242);
            this.dgvFuelTypes.TabIndex = 1;
            // 
            // FuelTypeID
            // 
            this.FuelTypeID.DataPropertyName = "FuelTypeID";
            this.FuelTypeID.HeaderText = "Fuel Type ID";
            this.FuelTypeID.Name = "FuelTypeID";
            this.FuelTypeID.ReadOnly = true;
            // 
            // FuelType
            // 
            this.FuelType.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.FuelType.DataPropertyName = "FuelType";
            this.FuelType.HeaderText = "Fuel Type";
            this.FuelType.Name = "FuelType";
            this.FuelType.ReadOnly = true;
            this.FuelType.Width = 600;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(27, 112);
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
            "Fuel Type ID",
            "Fuel Type"});
            this.cbFilterBy.Location = new System.Drawing.Point(113, 109);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(166, 29);
            this.cbFilterBy.TabIndex = 3;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtFilterValue
            // 
            this.txtFilterValue.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFilterValue.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtFilterValue.Location = new System.Drawing.Point(286, 109);
            this.txtFilterValue.MaxLength = 50;
            this.txtFilterValue.Multiline = true;
            this.txtFilterValue.Name = "txtFilterValue";
            this.txtFilterValue.Size = new System.Drawing.Size(206, 29);
            this.txtFilterValue.TabIndex = 4;
            this.txtFilterValue.TextChanged += new System.EventHandler(this.txtFilterValue_TextChanged);
            this.txtFilterValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtFilterValue_KeyPress);
            // 
            // btnAddFuelType
            // 
            this.btnAddFuelType.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddFuelType.Image = global::CRMS.Properties.Resources.add_32;
            this.btnAddFuelType.Location = new System.Drawing.Point(719, 94);
            this.btnAddFuelType.Name = "btnAddFuelType";
            this.btnAddFuelType.Size = new System.Drawing.Size(69, 44);
            this.btnAddFuelType.TabIndex = 5;
            this.btnAddFuelType.UseVisualStyleBackColor = true;
            this.btnAddFuelType.Click += new System.EventHandler(this.btnAddFuelType_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(27, 392);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(97, 22);
            this.label3.TabIndex = 6;
            this.label3.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 13F);
            this.lblRecordsCount.Location = new System.Drawing.Point(123, 392);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(28, 22);
            this.lblRecordsCount.TabIndex = 7;
            this.lblRecordsCount.Text = "??";
            // 
            // btnClose
            // 
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(646, 395);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(142, 36);
            this.btnClose.TabIndex = 8;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // cmsFuelTypes
            // 
            this.cmsFuelTypes.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowFuelTypeInfoItem,
            this.toolStripSeparator1,
            this.EditFuelTypeItem,
            this.DeleteFuelTypeItem});
            this.cmsFuelTypes.Name = "cmsFuelTypes";
            this.cmsFuelTypes.Size = new System.Drawing.Size(240, 100);
            // 
            // ShowFuelTypeInfoItem
            // 
            this.ShowFuelTypeInfoItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.ShowFuelTypeInfoItem.Name = "ShowFuelTypeInfoItem";
            this.ShowFuelTypeInfoItem.Size = new System.Drawing.Size(239, 30);
            this.ShowFuelTypeInfoItem.Text = "Show Fuel Type Info";
            this.ShowFuelTypeInfoItem.Click += new System.EventHandler(this.ShowFuelTypeInfoItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(236, 6);
            // 
            // EditFuelTypeItem
            // 
            this.EditFuelTypeItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.EditFuelTypeItem.Name = "EditFuelTypeItem";
            this.EditFuelTypeItem.Size = new System.Drawing.Size(239, 30);
            this.EditFuelTypeItem.Text = "Edit";
            this.EditFuelTypeItem.Click += new System.EventHandler(this.EditFuelTypeItem_Click);
            // 
            // DeleteFuelTypeItem
            // 
            this.DeleteFuelTypeItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.DeleteFuelTypeItem.Name = "DeleteFuelTypeItem";
            this.DeleteFuelTypeItem.Size = new System.Drawing.Size(239, 30);
            this.DeleteFuelTypeItem.Text = "Delete";
            this.DeleteFuelTypeItem.Click += new System.EventHandler(this.DeleteFuelTypeItem_Click);
            // 
            // frmListFuelTypes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnAddFuelType);
            this.Controls.Add(this.txtFilterValue);
            this.Controls.Add(this.cbFilterBy);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvFuelTypes);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmListFuelTypes";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "List FuelTypes";
            this.Load += new System.EventHandler(this.frmListFuelTypes_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvFuelTypes)).EndInit();
            this.cmsFuelTypes.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvFuelTypes;
        private System.Windows.Forms.DataGridViewTextBoxColumn FuelTypeID;
        private System.Windows.Forms.DataGridViewTextBoxColumn FuelType;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.TextBox txtFilterValue;
        private System.Windows.Forms.Button btnAddFuelType;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.ContextMenuStrip cmsFuelTypes;
        private System.Windows.Forms.ToolStripMenuItem ShowFuelTypeInfoItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem EditFuelTypeItem;
        private System.Windows.Forms.ToolStripMenuItem DeleteFuelTypeItem;
    }
}