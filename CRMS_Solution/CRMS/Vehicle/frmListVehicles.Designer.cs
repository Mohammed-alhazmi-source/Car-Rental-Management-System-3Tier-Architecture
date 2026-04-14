namespace CRMS.Vehicle
{
    partial class frmListVehicles
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
            this.dgvVehicles = new System.Windows.Forms.DataGridView();
            this.VehicleID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MakeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ModelName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Year = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Mileage = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FuelType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CategoryName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.IsAvailableForRent = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.cmsVehicles = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowVehicleInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.EditVehicleItem = new System.Windows.Forms.ToolStripMenuItem();
            this.DeleteVehicleItem = new System.Windows.Forms.ToolStripMenuItem();
            this.BookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.FindVehicleItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label2 = new System.Windows.Forms.Label();
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtFilterValue = new System.Windows.Forms.TextBox();
            this.cbFilterByAvailable = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnAddVehicle = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehicles)).BeginInit();
            this.cmsVehicles.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 25F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(434, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(346, 41);
            this.label1.TabIndex = 0;
            this.label1.Text = "Management Vehicles";
            // 
            // dgvVehicles
            // 
            this.dgvVehicles.AllowUserToAddRows = false;
            this.dgvVehicles.AllowUserToDeleteRows = false;
            this.dgvVehicles.AllowUserToOrderColumns = true;
            this.dgvVehicles.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 9F);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvVehicles.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvVehicles.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvVehicles.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.VehicleID,
            this.MakeName,
            this.ModelName,
            this.Year,
            this.Mileage,
            this.FuelType,
            this.CategoryName,
            this.IsAvailableForRent});
            this.dgvVehicles.ContextMenuStrip = this.cmsVehicles;
            this.dgvVehicles.Location = new System.Drawing.Point(12, 201);
            this.dgvVehicles.Name = "dgvVehicles";
            this.dgvVehicles.ReadOnly = true;
            this.dgvVehicles.Size = new System.Drawing.Size(1190, 358);
            this.dgvVehicles.TabIndex = 1;
            // 
            // VehicleID
            // 
            this.VehicleID.DataPropertyName = "VehicleID";
            this.VehicleID.HeaderText = "Vehicle ID";
            this.VehicleID.Name = "VehicleID";
            this.VehicleID.ReadOnly = true;
            // 
            // MakeName
            // 
            this.MakeName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.MakeName.DataPropertyName = "MakeName";
            this.MakeName.HeaderText = "Make Name";
            this.MakeName.Name = "MakeName";
            this.MakeName.ReadOnly = true;
            this.MakeName.Width = 150;
            // 
            // ModelName
            // 
            this.ModelName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.ModelName.DataPropertyName = "ModelName";
            this.ModelName.HeaderText = "Model Name";
            this.ModelName.Name = "ModelName";
            this.ModelName.ReadOnly = true;
            this.ModelName.Width = 150;
            // 
            // Year
            // 
            this.Year.DataPropertyName = "Year";
            this.Year.HeaderText = "Year";
            this.Year.Name = "Year";
            this.Year.ReadOnly = true;
            // 
            // Mileage
            // 
            this.Mileage.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.Mileage.DataPropertyName = "Mileage";
            this.Mileage.HeaderText = "Mileage";
            this.Mileage.Name = "Mileage";
            this.Mileage.ReadOnly = true;
            this.Mileage.Width = 120;
            // 
            // FuelType
            // 
            this.FuelType.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.FuelType.DataPropertyName = "FuelType";
            this.FuelType.HeaderText = "Fuel Type";
            this.FuelType.Name = "FuelType";
            this.FuelType.ReadOnly = true;
            this.FuelType.Width = 180;
            // 
            // CategoryName
            // 
            this.CategoryName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.CategoryName.DataPropertyName = "CategoryName";
            this.CategoryName.HeaderText = "Category Name";
            this.CategoryName.Name = "CategoryName";
            this.CategoryName.ReadOnly = true;
            this.CategoryName.Width = 200;
            // 
            // IsAvailableForRent
            // 
            this.IsAvailableForRent.DataPropertyName = "IsAvailableForRent";
            this.IsAvailableForRent.HeaderText = "Is Available";
            this.IsAvailableForRent.Name = "IsAvailableForRent";
            this.IsAvailableForRent.ReadOnly = true;
            this.IsAvailableForRent.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.IsAvailableForRent.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            // 
            // cmsVehicles
            // 
            this.cmsVehicles.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowVehicleInfoItem,
            this.toolStripSeparator1,
            this.EditVehicleItem,
            this.DeleteVehicleItem,
            this.BookingItem,
            this.FindVehicleItem});
            this.cmsVehicles.Name = "cmsVehicles";
            this.cmsVehicles.Size = new System.Drawing.Size(230, 182);
            this.cmsVehicles.Opening += new System.ComponentModel.CancelEventHandler(this.cmsVehicles_Opening);
            // 
            // ShowVehicleInfoItem
            // 
            this.ShowVehicleInfoItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.ShowVehicleInfoItem.Name = "ShowVehicleInfoItem";
            this.ShowVehicleInfoItem.Size = new System.Drawing.Size(229, 30);
            this.ShowVehicleInfoItem.Text = "Show Vehilce Info";
            this.ShowVehicleInfoItem.Click += new System.EventHandler(this.ShowVehicleInfoItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(226, 6);
            // 
            // EditVehicleItem
            // 
            this.EditVehicleItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.EditVehicleItem.Name = "EditVehicleItem";
            this.EditVehicleItem.Size = new System.Drawing.Size(229, 30);
            this.EditVehicleItem.Text = "Edit";
            this.EditVehicleItem.Click += new System.EventHandler(this.EditVehicleItem_Click);
            // 
            // DeleteVehicleItem
            // 
            this.DeleteVehicleItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.DeleteVehicleItem.Name = "DeleteVehicleItem";
            this.DeleteVehicleItem.Size = new System.Drawing.Size(229, 30);
            this.DeleteVehicleItem.Text = "Delete";
            this.DeleteVehicleItem.Click += new System.EventHandler(this.DeleteVehicleItem_Click);
            // 
            // BookingItem
            // 
            this.BookingItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.BookingItem.Name = "BookingItem";
            this.BookingItem.Size = new System.Drawing.Size(229, 30);
            this.BookingItem.Text = "Booking";
            this.BookingItem.Click += new System.EventHandler(this.BookingItem_Click);
            // 
            // FindVehicleItem
            // 
            this.FindVehicleItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.FindVehicleItem.Name = "FindVehicleItem";
            this.FindVehicleItem.Size = new System.Drawing.Size(229, 30);
            this.FindVehicleItem.Text = "Find Vehicle";
            this.FindVehicleItem.Click += new System.EventHandler(this.FindVehicleItem_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(26, 170);
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
            "Vehicle ID",
            "Make Name",
            "Model Name",
            "Year",
            "Mileage",
            "Fuel Type",
            "Category Name",
            "Is Available"});
            this.cbFilterBy.Location = new System.Drawing.Point(112, 167);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(179, 29);
            this.cbFilterBy.TabIndex = 3;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtFilterValue
            // 
            this.txtFilterValue.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFilterValue.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtFilterValue.Location = new System.Drawing.Point(297, 167);
            this.txtFilterValue.Name = "txtFilterValue";
            this.txtFilterValue.Size = new System.Drawing.Size(238, 28);
            this.txtFilterValue.TabIndex = 4;
            this.txtFilterValue.Visible = false;
            this.txtFilterValue.TextChanged += new System.EventHandler(this.txtFilterValue_TextChanged);
            this.txtFilterValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtFilterValue_KeyPress);
            // 
            // cbFilterByAvailable
            // 
            this.cbFilterByAvailable.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFilterByAvailable.Font = new System.Drawing.Font("Tahoma", 13F);
            this.cbFilterByAvailable.FormattingEnabled = true;
            this.cbFilterByAvailable.Items.AddRange(new object[] {
            "All",
            "Yes",
            "No"});
            this.cbFilterByAvailable.Location = new System.Drawing.Point(297, 166);
            this.cbFilterByAvailable.Name = "cbFilterByAvailable";
            this.cbFilterByAvailable.Size = new System.Drawing.Size(88, 29);
            this.cbFilterByAvailable.TabIndex = 5;
            this.cbFilterByAvailable.Visible = false;
            this.cbFilterByAvailable.SelectedIndexChanged += new System.EventHandler(this.cbFilterByAvailable_SelectedIndexChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(26, 562);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(97, 22);
            this.label3.TabIndex = 7;
            this.label3.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 13F);
            this.lblRecordsCount.Location = new System.Drawing.Point(120, 562);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(37, 22);
            this.lblRecordsCount.TabIndex = 8;
            this.lblRecordsCount.Text = "???";
            // 
            // btnClose
            // 
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(1032, 565);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(170, 44);
            this.btnClose.TabIndex = 9;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnAddVehicle
            // 
            this.btnAddVehicle.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddVehicle.Image = global::CRMS.Properties.Resources.add_32;
            this.btnAddVehicle.Location = new System.Drawing.Point(1115, 132);
            this.btnAddVehicle.Name = "btnAddVehicle";
            this.btnAddVehicle.Size = new System.Drawing.Size(87, 64);
            this.btnAddVehicle.TabIndex = 6;
            this.btnAddVehicle.UseVisualStyleBackColor = true;
            this.btnAddVehicle.Click += new System.EventHandler(this.btnAddVehicle_Click);
            // 
            // frmListVehicles
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1214, 620);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnAddVehicle);
            this.Controls.Add(this.cbFilterByAvailable);
            this.Controls.Add(this.txtFilterValue);
            this.Controls.Add(this.cbFilterBy);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvVehicles);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.Name = "frmListVehicles";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "List Vehicles";
            this.Load += new System.EventHandler(this.frmListVehicles_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehicles)).EndInit();
            this.cmsVehicles.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvVehicles;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.DataGridViewTextBoxColumn VehicleID;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeName;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Year;
        private System.Windows.Forms.DataGridViewTextBoxColumn Mileage;
        private System.Windows.Forms.DataGridViewTextBoxColumn FuelType;
        private System.Windows.Forms.DataGridViewTextBoxColumn CategoryName;
        private System.Windows.Forms.DataGridViewCheckBoxColumn IsAvailableForRent;
        private System.Windows.Forms.TextBox txtFilterValue;
        private System.Windows.Forms.ComboBox cbFilterByAvailable;
        private System.Windows.Forms.Button btnAddVehicle;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.ContextMenuStrip cmsVehicles;
        private System.Windows.Forms.ToolStripMenuItem ShowVehicleInfoItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem EditVehicleItem;
        private System.Windows.Forms.ToolStripMenuItem DeleteVehicleItem;
        private System.Windows.Forms.ToolStripMenuItem BookingItem;
        private System.Windows.Forms.ToolStripMenuItem FindVehicleItem;
    }
}