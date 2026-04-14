namespace CRMS.VehicleReturn
{
    partial class frmListVehiclesReturn
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
            this.label1 = new System.Windows.Forms.Label();
            this.dgvVehiclesReturn = new System.Windows.Forms.DataGridView();
            this.cmsVehiclesReturn = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowVehicleReturnInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.DeleteVehicleReturnItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label2 = new System.Windows.Forms.Label();
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtFilterValue = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.ReturnID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BookingID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.VehicleID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MakeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ModelName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.FuelType = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CategoryName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ActualReturnDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Mileage = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ShowVehicleInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ShowBookingInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehiclesReturn)).BeginInit();
            this.cmsVehiclesReturn.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(9)))));
            this.label1.Location = new System.Drawing.Point(289, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(533, 48);
            this.label1.TabIndex = 0;
            this.label1.Text = "Management Vehicles Return";
            // 
            // dgvVehiclesReturn
            // 
            this.dgvVehiclesReturn.AllowUserToAddRows = false;
            this.dgvVehiclesReturn.AllowUserToDeleteRows = false;
            this.dgvVehiclesReturn.AllowUserToOrderColumns = true;
            this.dgvVehiclesReturn.BackgroundColor = System.Drawing.Color.White;
            this.dgvVehiclesReturn.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvVehiclesReturn.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ReturnID,
            this.BookingID,
            this.VehicleID,
            this.MakeName,
            this.ModelName,
            this.FuelType,
            this.CategoryName,
            this.ActualReturnDate,
            this.Mileage});
            this.dgvVehiclesReturn.ContextMenuStrip = this.cmsVehiclesReturn;
            this.dgvVehiclesReturn.Location = new System.Drawing.Point(12, 184);
            this.dgvVehiclesReturn.Name = "dgvVehiclesReturn";
            this.dgvVehiclesReturn.ReadOnly = true;
            this.dgvVehiclesReturn.Size = new System.Drawing.Size(1209, 374);
            this.dgvVehiclesReturn.TabIndex = 1;
            // 
            // cmsVehiclesReturn
            // 
            this.cmsVehiclesReturn.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowVehicleReturnInfoItem,
            this.ShowVehicleInfoItem,
            this.ShowBookingInfoItem,
            this.toolStripSeparator1,
            this.DeleteVehicleReturnItem});
            this.cmsVehiclesReturn.Name = "cmsVehiclesReturn";
            this.cmsVehiclesReturn.Size = new System.Drawing.Size(290, 130);
            // 
            // ShowVehicleReturnInfoItem
            // 
            this.ShowVehicleReturnInfoItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.ShowVehicleReturnInfoItem.Name = "ShowVehicleReturnInfoItem";
            this.ShowVehicleReturnInfoItem.Size = new System.Drawing.Size(289, 30);
            this.ShowVehicleReturnInfoItem.Text = "Show Vehicle Return Info";
            this.ShowVehicleReturnInfoItem.Click += new System.EventHandler(this.ShowVehicleReturnInfoItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(286, 6);
            // 
            // DeleteVehicleReturnItem
            // 
            this.DeleteVehicleReturnItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.DeleteVehicleReturnItem.Name = "DeleteVehicleReturnItem";
            this.DeleteVehicleReturnItem.Size = new System.Drawing.Size(289, 30);
            this.DeleteVehicleReturnItem.Text = "Delete";
            this.DeleteVehicleReturnItem.Click += new System.EventHandler(this.DeleteVehicleReturnItem_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(25, 149);
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
            "Return ID",
            "Booking ID",
            "Vehicle ID",
            "Make Name",
            "Model Name",
            "Fuel Type",
            "Category Name"});
            this.cbFilterBy.Location = new System.Drawing.Point(111, 146);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(254, 29);
            this.cbFilterBy.TabIndex = 3;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtFilterValue
            // 
            this.txtFilterValue.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFilterValue.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtFilterValue.Location = new System.Drawing.Point(372, 146);
            this.txtFilterValue.MaxLength = 100;
            this.txtFilterValue.Multiline = true;
            this.txtFilterValue.Name = "txtFilterValue";
            this.txtFilterValue.Size = new System.Drawing.Size(454, 29);
            this.txtFilterValue.TabIndex = 4;
            this.txtFilterValue.TextChanged += new System.EventHandler(this.txtFilterValue_TextChanged);
            this.txtFilterValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtFilterValue_KeyPress);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(25, 561);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(97, 22);
            this.label3.TabIndex = 5;
            this.label3.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblRecordsCount.Location = new System.Drawing.Point(119, 563);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(45, 19);
            this.lblRecordsCount.TabIndex = 6;
            this.lblRecordsCount.Text = "[???]";
            // 
            // btnClose
            // 
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(1022, 564);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(199, 35);
            this.btnClose.TabIndex = 7;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            // 
            // ReturnID
            // 
            this.ReturnID.DataPropertyName = "ReturnID";
            this.ReturnID.HeaderText = "Return ID";
            this.ReturnID.Name = "ReturnID";
            this.ReturnID.ReadOnly = true;
            // 
            // BookingID
            // 
            this.BookingID.DataPropertyName = "BookingID";
            this.BookingID.HeaderText = "Booking ID";
            this.BookingID.Name = "BookingID";
            this.BookingID.ReadOnly = true;
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
            // FuelType
            // 
            this.FuelType.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.FuelType.DataPropertyName = "FuelType";
            this.FuelType.HeaderText = "Fuel Type";
            this.FuelType.Name = "FuelType";
            this.FuelType.ReadOnly = true;
            this.FuelType.Width = 145;
            // 
            // CategoryName
            // 
            this.CategoryName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.CategoryName.DataPropertyName = "CategoryName";
            this.CategoryName.HeaderText = "Category Name";
            this.CategoryName.Name = "CategoryName";
            this.CategoryName.ReadOnly = true;
            this.CategoryName.Width = 150;
            // 
            // ActualReturnDate
            // 
            this.ActualReturnDate.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.ActualReturnDate.DataPropertyName = "ActualReturnDate";
            this.ActualReturnDate.HeaderText = "Actual Return Date";
            this.ActualReturnDate.Name = "ActualReturnDate";
            this.ActualReturnDate.ReadOnly = true;
            this.ActualReturnDate.Width = 140;
            // 
            // Mileage
            // 
            this.Mileage.DataPropertyName = "Mileage";
            this.Mileage.HeaderText = "Mileage";
            this.Mileage.Name = "Mileage";
            this.Mileage.ReadOnly = true;
            // 
            // ShowVehicleInfoItem
            // 
            this.ShowVehicleInfoItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.ShowVehicleInfoItem.Name = "ShowVehicleInfoItem";
            this.ShowVehicleInfoItem.Size = new System.Drawing.Size(289, 30);
            this.ShowVehicleInfoItem.Text = "Show Vehicle Info";
            this.ShowVehicleInfoItem.Click += new System.EventHandler(this.ShowVehicleInfoItem_Click);
            // 
            // ShowBookingInfoItem
            // 
            this.ShowBookingInfoItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.ShowBookingInfoItem.Name = "ShowBookingInfoItem";
            this.ShowBookingInfoItem.Size = new System.Drawing.Size(289, 30);
            this.ShowBookingInfoItem.Text = "Show Booking Info";
            this.ShowBookingInfoItem.Click += new System.EventHandler(this.ShowBookingInfoItem_Click);
            // 
            // frmListVehiclesReturn
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1233, 617);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtFilterValue);
            this.Controls.Add(this.cbFilterBy);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvVehiclesReturn);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.Name = "frmListVehiclesReturn";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "List Vehicles Return";
            this.Load += new System.EventHandler(this.frmListVehiclesReturn_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehiclesReturn)).EndInit();
            this.cmsVehiclesReturn.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvVehiclesReturn;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.TextBox txtFilterValue;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.ContextMenuStrip cmsVehiclesReturn;
        private System.Windows.Forms.ToolStripMenuItem ShowVehicleReturnInfoItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem DeleteVehicleReturnItem;
        private System.Windows.Forms.DataGridViewTextBoxColumn ReturnID;
        private System.Windows.Forms.DataGridViewTextBoxColumn BookingID;
        private System.Windows.Forms.DataGridViewTextBoxColumn VehicleID;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeName;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelName;
        private System.Windows.Forms.DataGridViewTextBoxColumn FuelType;
        private System.Windows.Forms.DataGridViewTextBoxColumn CategoryName;
        private System.Windows.Forms.DataGridViewTextBoxColumn ActualReturnDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn Mileage;
        private System.Windows.Forms.ToolStripMenuItem ShowVehicleInfoItem;
        private System.Windows.Forms.ToolStripMenuItem ShowBookingInfoItem;
    }
}