namespace CRMS.RentalBooking.Controls
{
    partial class ctrlRentalBooking
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.dgvVehicles = new System.Windows.Forms.DataGridView();
            this.VehicleID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MakeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ModelName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Mileage = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.IsAvailableForRent = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.cmsBooking = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.SetBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ctrlMakeCardWithFilter1 = new CRMS.Make.Controls.ctrlMakeCardWithFilter();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehicles)).BeginInit();
            this.cmsBooking.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.lblRecordsCount);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.dgvVehicles);
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 13F);
            this.groupBox1.ForeColor = System.Drawing.Color.DimGray;
            this.groupBox1.Location = new System.Drawing.Point(20, 248);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1075, 307);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Make Models";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblRecordsCount.ForeColor = System.Drawing.Color.Black;
            this.lblRecordsCount.Location = new System.Drawing.Point(118, 273);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(33, 19);
            this.lblRecordsCount.TabIndex = 4;
            this.lblRecordsCount.Text = "???";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(21, 271);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(97, 22);
            this.label1.TabIndex = 3;
            this.label1.Text = "# Records:";
            // 
            // dgvVehicles
            // 
            this.dgvVehicles.AllowUserToAddRows = false;
            this.dgvVehicles.AllowUserToDeleteRows = false;
            this.dgvVehicles.AllowUserToOrderColumns = true;
            this.dgvVehicles.BackgroundColor = System.Drawing.Color.White;
            this.dgvVehicles.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvVehicles.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.VehicleID,
            this.MakeName,
            this.ModelName,
            this.Mileage,
            this.IsAvailableForRent});
            this.dgvVehicles.ContextMenuStrip = this.cmsBooking;
            this.dgvVehicles.Location = new System.Drawing.Point(6, 35);
            this.dgvVehicles.Name = "dgvVehicles";
            this.dgvVehicles.ReadOnly = true;
            this.dgvVehicles.Size = new System.Drawing.Size(1063, 229);
            this.dgvVehicles.TabIndex = 2;
            // 
            // VehicleID
            // 
            this.VehicleID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.VehicleID.DataPropertyName = "VehicleID";
            this.VehicleID.HeaderText = "Vehicle ID";
            this.VehicleID.Name = "VehicleID";
            this.VehicleID.ReadOnly = true;
            this.VehicleID.Width = 150;
            // 
            // MakeName
            // 
            this.MakeName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.MakeName.DataPropertyName = "MakeName";
            this.MakeName.HeaderText = "Make Name";
            this.MakeName.Name = "MakeName";
            this.MakeName.ReadOnly = true;
            this.MakeName.Width = 295;
            // 
            // ModelName
            // 
            this.ModelName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.ModelName.DataPropertyName = "ModelName";
            this.ModelName.HeaderText = "Model Name";
            this.ModelName.Name = "ModelName";
            this.ModelName.ReadOnly = true;
            this.ModelName.Width = 295;
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
            // IsAvailableForRent
            // 
            this.IsAvailableForRent.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.IsAvailableForRent.DataPropertyName = "IsAvailableForRent";
            this.IsAvailableForRent.HeaderText = "Is Available";
            this.IsAvailableForRent.Name = "IsAvailableForRent";
            this.IsAvailableForRent.ReadOnly = true;
            this.IsAvailableForRent.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.IsAvailableForRent.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.IsAvailableForRent.Width = 140;
            // 
            // cmsBooking
            // 
            this.cmsBooking.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.SetBookingItem});
            this.cmsBooking.Name = "cmsBooking";
            this.cmsBooking.Size = new System.Drawing.Size(146, 34);
            this.cmsBooking.Opening += new System.ComponentModel.CancelEventHandler(this.cmsBooking_Opening);
            // 
            // SetBookingItem
            // 
            this.SetBookingItem.Font = new System.Drawing.Font("Segoe UI", 13F);
            this.SetBookingItem.Name = "SetBookingItem";
            this.SetBookingItem.Size = new System.Drawing.Size(145, 30);
            this.SetBookingItem.Text = "Booking";
            this.SetBookingItem.Click += new System.EventHandler(this.SetBookingItem_Click);
            // 
            // ctrlMakeCardWithFilter1
            // 
            this.ctrlMakeCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCardWithFilter1.FilterEnabled = true;
            this.ctrlMakeCardWithFilter1.Location = new System.Drawing.Point(150, 2);
            this.ctrlMakeCardWithFilter1.Name = "ctrlMakeCardWithFilter1";
            this.ctrlMakeCardWithFilter1.Size = new System.Drawing.Size(778, 251);
            this.ctrlMakeCardWithFilter1.TabIndex = 0;
            this.ctrlMakeCardWithFilter1.OnMakeSelected += new System.EventHandler<CRMS.Make.Controls.ctrlMakeCardWithFilter.MakeSelectedEventArgs>(this.ctrlMakeCardWithFilter1_OnMakeSelected);
            // 
            // ctrlRentalBooking
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.ctrlMakeCardWithFilter1);
            this.Name = "ctrlRentalBooking";
            this.Size = new System.Drawing.Size(1114, 571);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvVehicles)).EndInit();
            this.cmsBooking.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Make.Controls.ctrlMakeCardWithFilter ctrlMakeCardWithFilter1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgvVehicles;
        private System.Windows.Forms.DataGridViewTextBoxColumn VehicleID;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeName;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Mileage;
        private System.Windows.Forms.DataGridViewCheckBoxColumn IsAvailableForRent;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ContextMenuStrip cmsBooking;
        private System.Windows.Forms.ToolStripMenuItem SetBookingItem;
    }
}
