namespace CRMS.RentalBooking
{
    partial class frmListRentalsBooking
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
            this.dgvRentalsBooking = new System.Windows.Forms.DataGridView();
            this.BookingID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CustomerName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.VehicleID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MakeName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ModelName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.RentalStartDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.RentalEndDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmsRentalsBooking = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.ShowRentalBookingInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.EditRentalBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.DeleteRentalBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.label2 = new System.Windows.Forms.Label();
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtFilterValue = new System.Windows.Forms.TextBox();
            this.btnAddNewRentalBooking = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.lblRecordsCount = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvRentalsBooking)).BeginInit();
            this.cmsRentalsBooking.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(350, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(544, 48);
            this.label1.TabIndex = 0;
            this.label1.Text = "Management Rentals Booking";
            // 
            // dgvRentalsBooking
            // 
            this.dgvRentalsBooking.AllowUserToAddRows = false;
            this.dgvRentalsBooking.AllowUserToDeleteRows = false;
            this.dgvRentalsBooking.AllowUserToOrderColumns = true;
            this.dgvRentalsBooking.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 9F);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvRentalsBooking.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvRentalsBooking.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvRentalsBooking.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.BookingID,
            this.CustomerName,
            this.VehicleID,
            this.MakeName,
            this.ModelName,
            this.RentalStartDate,
            this.RentalEndDate});
            this.dgvRentalsBooking.ContextMenuStrip = this.cmsRentalsBooking;
            this.dgvRentalsBooking.Location = new System.Drawing.Point(12, 204);
            this.dgvRentalsBooking.Name = "dgvRentalsBooking";
            this.dgvRentalsBooking.ReadOnly = true;
            this.dgvRentalsBooking.Size = new System.Drawing.Size(1221, 356);
            this.dgvRentalsBooking.TabIndex = 1;
            // 
            // BookingID
            // 
            this.BookingID.DataPropertyName = "BookingID";
            this.BookingID.HeaderText = "Booking ID";
            this.BookingID.Name = "BookingID";
            this.BookingID.ReadOnly = true;
            // 
            // CustomerName
            // 
            this.CustomerName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.CustomerName.DataPropertyName = "CustomerName";
            this.CustomerName.HeaderText = "Customer Name";
            this.CustomerName.Name = "CustomerName";
            this.CustomerName.ReadOnly = true;
            this.CustomerName.Width = 250;
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
            this.MakeName.Width = 200;
            // 
            // ModelName
            // 
            this.ModelName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.ModelName.DataPropertyName = "ModelName";
            this.ModelName.HeaderText = "Model Name";
            this.ModelName.Name = "ModelName";
            this.ModelName.ReadOnly = true;
            this.ModelName.Width = 200;
            // 
            // RentalStartDate
            // 
            this.RentalStartDate.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.RentalStartDate.DataPropertyName = "RentalStartDate";
            this.RentalStartDate.HeaderText = "Rental Start Date";
            this.RentalStartDate.Name = "RentalStartDate";
            this.RentalStartDate.ReadOnly = true;
            this.RentalStartDate.Width = 150;
            // 
            // RentalEndDate
            // 
            this.RentalEndDate.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.None;
            this.RentalEndDate.DataPropertyName = "RentalEndDate";
            this.RentalEndDate.HeaderText = "Rental End Date";
            this.RentalEndDate.Name = "RentalEndDate";
            this.RentalEndDate.ReadOnly = true;
            this.RentalEndDate.Width = 150;
            // 
            // cmsRentalsBooking
            // 
            this.cmsRentalsBooking.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ShowRentalBookingInfoItem,
            this.toolStripSeparator1,
            this.EditRentalBookingItem,
            this.DeleteRentalBookingItem});
            this.cmsRentalsBooking.Name = "cmsRentalsBooking";
            this.cmsRentalsBooking.Size = new System.Drawing.Size(295, 100);
            // 
            // ShowRentalBookingInfoItem
            // 
            this.ShowRentalBookingInfoItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.ShowRentalBookingInfoItem.Name = "ShowRentalBookingInfoItem";
            this.ShowRentalBookingInfoItem.Size = new System.Drawing.Size(294, 30);
            this.ShowRentalBookingInfoItem.Text = "Show Rental Booking Info";
            this.ShowRentalBookingInfoItem.Click += new System.EventHandler(this.ShowRentalBookingInfoItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(291, 6);
            // 
            // EditRentalBookingItem
            // 
            this.EditRentalBookingItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.EditRentalBookingItem.Name = "EditRentalBookingItem";
            this.EditRentalBookingItem.Size = new System.Drawing.Size(294, 30);
            this.EditRentalBookingItem.Text = "Edit";
            this.EditRentalBookingItem.Click += new System.EventHandler(this.EditRentalBookingItem_Click);
            // 
            // DeleteRentalBookingItem
            // 
            this.DeleteRentalBookingItem.Font = new System.Drawing.Font("Segoe UI", 14F);
            this.DeleteRentalBookingItem.Name = "DeleteRentalBookingItem";
            this.DeleteRentalBookingItem.Size = new System.Drawing.Size(294, 30);
            this.DeleteRentalBookingItem.Text = "Delete";
            this.DeleteRentalBookingItem.Click += new System.EventHandler(this.DeleteRentalBookingItem_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(27, 167);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 22);
            this.label2.TabIndex = 2;
            this.label2.Text = "Filter By:";
            // 
            // cbFilterBy
            // 
            this.cbFilterBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFilterBy.Font = new System.Drawing.Font("Tahoma", 14F);
            this.cbFilterBy.FormattingEnabled = true;
            this.cbFilterBy.Items.AddRange(new object[] {
            "None",
            "Booking ID",
            "Customer Name",
            "Vehicle ID",
            "Make Name",
            "Model Name"});
            this.cbFilterBy.Location = new System.Drawing.Point(113, 162);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(274, 31);
            this.cbFilterBy.TabIndex = 3;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtFilterValue
            // 
            this.txtFilterValue.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFilterValue.Font = new System.Drawing.Font("Tahoma", 14F);
            this.txtFilterValue.Location = new System.Drawing.Point(394, 162);
            this.txtFilterValue.Name = "txtFilterValue";
            this.txtFilterValue.Size = new System.Drawing.Size(341, 30);
            this.txtFilterValue.TabIndex = 4;
            this.txtFilterValue.Visible = false;
            this.txtFilterValue.TextChanged += new System.EventHandler(this.txtFilterValue_TextChanged);
            this.txtFilterValue.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtFilterValue_KeyPress);
            // 
            // btnAddNewRentalBooking
            // 
            this.btnAddNewRentalBooking.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddNewRentalBooking.Font = new System.Drawing.Font("Tahoma", 8F);
            this.btnAddNewRentalBooking.Image = global::CRMS.Properties.Resources.add_32;
            this.btnAddNewRentalBooking.Location = new System.Drawing.Point(1158, 146);
            this.btnAddNewRentalBooking.Name = "btnAddNewRentalBooking";
            this.btnAddNewRentalBooking.Size = new System.Drawing.Size(75, 47);
            this.btnAddNewRentalBooking.TabIndex = 5;
            this.btnAddNewRentalBooking.UseVisualStyleBackColor = true;
            this.btnAddNewRentalBooking.Click += new System.EventHandler(this.btnAddNewRentalBooking_Click);
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(1032, 566);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(201, 37);
            this.btnClose.TabIndex = 6;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(27, 566);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(97, 22);
            this.label3.TabIndex = 7;
            this.label3.Text = "# Records:";
            // 
            // lblRecordsCount
            // 
            this.lblRecordsCount.AutoSize = true;
            this.lblRecordsCount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblRecordsCount.Location = new System.Drawing.Point(122, 569);
            this.lblRecordsCount.Name = "lblRecordsCount";
            this.lblRecordsCount.Size = new System.Drawing.Size(33, 19);
            this.lblRecordsCount.TabIndex = 8;
            this.lblRecordsCount.Text = "???";
            // 
            // frmListRentalsBooking
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(1245, 618);
            this.Controls.Add(this.lblRecordsCount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnAddNewRentalBooking);
            this.Controls.Add(this.txtFilterValue);
            this.Controls.Add(this.cbFilterBy);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvRentalsBooking);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.Name = "frmListRentalsBooking";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "List Rentals Booking";
            this.Load += new System.EventHandler(this.frmListRentalsBooking_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvRentalsBooking)).EndInit();
            this.cmsRentalsBooking.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvRentalsBooking;
        private System.Windows.Forms.DataGridViewTextBoxColumn BookingID;
        private System.Windows.Forms.DataGridViewTextBoxColumn CustomerName;
        private System.Windows.Forms.DataGridViewTextBoxColumn VehicleID;
        private System.Windows.Forms.DataGridViewTextBoxColumn MakeName;
        private System.Windows.Forms.DataGridViewTextBoxColumn ModelName;
        private System.Windows.Forms.DataGridViewTextBoxColumn RentalStartDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn RentalEndDate;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.TextBox txtFilterValue;
        private System.Windows.Forms.Button btnAddNewRentalBooking;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblRecordsCount;
        private System.Windows.Forms.ContextMenuStrip cmsRentalsBooking;
        private System.Windows.Forms.ToolStripMenuItem ShowRentalBookingInfoItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem EditRentalBookingItem;
        private System.Windows.Forms.ToolStripMenuItem DeleteRentalBookingItem;
    }
}