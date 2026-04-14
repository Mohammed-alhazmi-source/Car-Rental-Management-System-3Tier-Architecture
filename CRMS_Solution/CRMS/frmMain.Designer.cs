namespace CRMS
{
    partial class frmMain
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
            this.menuStrip = new System.Windows.Forms.MenuStrip();
            this.ApplicationsItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ManagementRentalBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AddNewBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ManagementRentalsBookingItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator6 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementVehicleReturnItem = new System.Windows.Forms.ToolStripMenuItem();
            this.VehicleReturnItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ManagementVehiclesReturnItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator7 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementRentalsTransactionItem = new System.Windows.Forms.ToolStripMenuItem();
            this.PeopleItem = new System.Windows.Forms.ToolStripMenuItem();
            this.CustomersItem = new System.Windows.Forms.ToolStripMenuItem();
            this.VehiclesItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ManagementVehiclesItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementMakesItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementMakeModelsItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementFuelTypesItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
            this.ManagementCategoriesItem = new System.Windows.Forms.ToolStripMenuItem();
            this.UsersItem = new System.Windows.Forms.ToolStripMenuItem();
            this.AccountSettingsItem = new System.Windows.Forms.ToolStripMenuItem();
            this.CurrentUserInfoItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ChangePasswordItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.SignOutItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.menuStrip.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip
            // 
            this.menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ApplicationsItem,
            this.PeopleItem,
            this.CustomersItem,
            this.VehiclesItem,
            this.UsersItem,
            this.AccountSettingsItem});
            this.menuStrip.Location = new System.Drawing.Point(0, 0);
            this.menuStrip.Name = "menuStrip";
            this.menuStrip.Size = new System.Drawing.Size(1370, 72);
            this.menuStrip.TabIndex = 4;
            this.menuStrip.Text = "menuStrip1";
            // 
            // ApplicationsItem
            // 
            this.ApplicationsItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ManagementRentalBookingItem,
            this.toolStripSeparator6,
            this.ManagementVehicleReturnItem,
            this.toolStripSeparator7,
            this.ManagementRentalsTransactionItem});
            this.ApplicationsItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.ApplicationsItem.Image = global::CRMS.Properties.Resources.Manage_Applications_64;
            this.ApplicationsItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.ApplicationsItem.Name = "ApplicationsItem";
            this.ApplicationsItem.Size = new System.Drawing.Size(240, 68);
            this.ApplicationsItem.Text = "Applications";
            // 
            // ManagementRentalBookingItem
            // 
            this.ManagementRentalBookingItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.AddNewBookingItem,
            this.ManagementRentalsBookingItem});
            this.ManagementRentalBookingItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementRentalBookingItem.Name = "ManagementRentalBookingItem";
            this.ManagementRentalBookingItem.Size = new System.Drawing.Size(375, 32);
            this.ManagementRentalBookingItem.Text = "Management Rental Booking";
            // 
            // AddNewBookingItem
            // 
            this.AddNewBookingItem.Name = "AddNewBookingItem";
            this.AddNewBookingItem.Size = new System.Drawing.Size(345, 32);
            this.AddNewBookingItem.Text = "Add New Booking";
            this.AddNewBookingItem.Click += new System.EventHandler(this.AddNewBookingItem_Click);
            // 
            // ManagementRentalsBookingItem
            // 
            this.ManagementRentalsBookingItem.Name = "ManagementRentalsBookingItem";
            this.ManagementRentalsBookingItem.Size = new System.Drawing.Size(345, 32);
            this.ManagementRentalsBookingItem.Text = "Management Rentals Booking";
            this.ManagementRentalsBookingItem.Click += new System.EventHandler(this.ManagementRentalsBookingItem_Click);
            // 
            // toolStripSeparator6
            // 
            this.toolStripSeparator6.Name = "toolStripSeparator6";
            this.toolStripSeparator6.Size = new System.Drawing.Size(372, 6);
            // 
            // ManagementVehicleReturnItem
            // 
            this.ManagementVehicleReturnItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.VehicleReturnItem,
            this.ManagementVehiclesReturnItem});
            this.ManagementVehicleReturnItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementVehicleReturnItem.Name = "ManagementVehicleReturnItem";
            this.ManagementVehicleReturnItem.Size = new System.Drawing.Size(375, 32);
            this.ManagementVehicleReturnItem.Text = "Management Vehicle Return";
            // 
            // VehicleReturnItem
            // 
            this.VehicleReturnItem.Name = "VehicleReturnItem";
            this.VehicleReturnItem.Size = new System.Drawing.Size(336, 32);
            this.VehicleReturnItem.Text = "Vehicle Return";
            this.VehicleReturnItem.Click += new System.EventHandler(this.VehicleReturnItem_Click);
            // 
            // ManagementVehiclesReturnItem
            // 
            this.ManagementVehiclesReturnItem.Name = "ManagementVehiclesReturnItem";
            this.ManagementVehiclesReturnItem.Size = new System.Drawing.Size(336, 32);
            this.ManagementVehiclesReturnItem.Text = "Management Vehicles Return";
            this.ManagementVehiclesReturnItem.Click += new System.EventHandler(this.ManagementVehiclesReturnItem_Click);
            // 
            // toolStripSeparator7
            // 
            this.toolStripSeparator7.Name = "toolStripSeparator7";
            this.toolStripSeparator7.Size = new System.Drawing.Size(372, 6);
            // 
            // ManagementRentalsTransactionItem
            // 
            this.ManagementRentalsTransactionItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementRentalsTransactionItem.Name = "ManagementRentalsTransactionItem";
            this.ManagementRentalsTransactionItem.Size = new System.Drawing.Size(375, 32);
            this.ManagementRentalsTransactionItem.Text = "Management Rentals Transaction";
            this.ManagementRentalsTransactionItem.Click += new System.EventHandler(this.ManagementRentalsTransactionItem_Click);
            // 
            // PeopleItem
            // 
            this.PeopleItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.PeopleItem.Image = global::CRMS.Properties.Resources.People_64;
            this.PeopleItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.PeopleItem.Name = "PeopleItem";
            this.PeopleItem.Size = new System.Drawing.Size(174, 68);
            this.PeopleItem.Text = "People";
            this.PeopleItem.Click += new System.EventHandler(this.PeopleItem_Click);
            // 
            // CustomersItem
            // 
            this.CustomersItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.CustomersItem.Image = global::CRMS.Properties.Resources.Drivers_64;
            this.CustomersItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.CustomersItem.Name = "CustomersItem";
            this.CustomersItem.Size = new System.Drawing.Size(218, 68);
            this.CustomersItem.Text = "Customers";
            this.CustomersItem.Click += new System.EventHandler(this.CustomersItem_Click);
            // 
            // VehiclesItem
            // 
            this.VehiclesItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ManagementVehiclesItem,
            this.toolStripSeparator2,
            this.ManagementMakesItem,
            this.toolStripSeparator3,
            this.ManagementMakeModelsItem,
            this.toolStripSeparator4,
            this.ManagementFuelTypesItem,
            this.toolStripSeparator5,
            this.ManagementCategoriesItem});
            this.VehiclesItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.VehiclesItem.Image = global::CRMS.Properties.Resources.traffic_jam_64px;
            this.VehiclesItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.VehiclesItem.Name = "VehiclesItem";
            this.VehiclesItem.Size = new System.Drawing.Size(188, 68);
            this.VehiclesItem.Text = "Vehicles";
            // 
            // ManagementVehiclesItem
            // 
            this.ManagementVehiclesItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementVehiclesItem.Name = "ManagementVehiclesItem";
            this.ManagementVehiclesItem.Size = new System.Drawing.Size(328, 32);
            this.ManagementVehiclesItem.Text = "Management Vehicles";
            this.ManagementVehiclesItem.Click += new System.EventHandler(this.ManagementVehiclesItem_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(325, 6);
            // 
            // ManagementMakesItem
            // 
            this.ManagementMakesItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementMakesItem.Name = "ManagementMakesItem";
            this.ManagementMakesItem.Size = new System.Drawing.Size(328, 32);
            this.ManagementMakesItem.Text = "Management Makes";
            this.ManagementMakesItem.Click += new System.EventHandler(this.ManagementMakesItem_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(325, 6);
            // 
            // ManagementMakeModelsItem
            // 
            this.ManagementMakeModelsItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementMakeModelsItem.Name = "ManagementMakeModelsItem";
            this.ManagementMakeModelsItem.Size = new System.Drawing.Size(328, 32);
            this.ManagementMakeModelsItem.Text = "Management Make Models";
            this.ManagementMakeModelsItem.Click += new System.EventHandler(this.ManagementMakeModelsItem_Click);
            // 
            // toolStripSeparator4
            // 
            this.toolStripSeparator4.Name = "toolStripSeparator4";
            this.toolStripSeparator4.Size = new System.Drawing.Size(325, 6);
            // 
            // ManagementFuelTypesItem
            // 
            this.ManagementFuelTypesItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementFuelTypesItem.Name = "ManagementFuelTypesItem";
            this.ManagementFuelTypesItem.Size = new System.Drawing.Size(328, 32);
            this.ManagementFuelTypesItem.Text = "Management Fuel Types";
            this.ManagementFuelTypesItem.Click += new System.EventHandler(this.ManagementFuelTypesItem_Click);
            // 
            // toolStripSeparator5
            // 
            this.toolStripSeparator5.Name = "toolStripSeparator5";
            this.toolStripSeparator5.Size = new System.Drawing.Size(325, 6);
            // 
            // ManagementCategoriesItem
            // 
            this.ManagementCategoriesItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ManagementCategoriesItem.Name = "ManagementCategoriesItem";
            this.ManagementCategoriesItem.Size = new System.Drawing.Size(328, 32);
            this.ManagementCategoriesItem.Text = "Management Categories";
            this.ManagementCategoriesItem.Click += new System.EventHandler(this.ManagementCategoriesItem_Click);
            // 
            // UsersItem
            // 
            this.UsersItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.UsersItem.Image = global::CRMS.Properties.Resources.Users_2_64;
            this.UsersItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.UsersItem.Name = "UsersItem";
            this.UsersItem.Size = new System.Drawing.Size(157, 68);
            this.UsersItem.Text = "Users";
            this.UsersItem.Click += new System.EventHandler(this.UsersItem_Click);
            // 
            // AccountSettingsItem
            // 
            this.AccountSettingsItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.CurrentUserInfoItem,
            this.ChangePasswordItem,
            this.toolStripSeparator1,
            this.SignOutItem});
            this.AccountSettingsItem.Font = new System.Drawing.Font("Segoe UI", 20F);
            this.AccountSettingsItem.Image = global::CRMS.Properties.Resources.account_settings_64;
            this.AccountSettingsItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.AccountSettingsItem.Name = "AccountSettingsItem";
            this.AccountSettingsItem.Size = new System.Drawing.Size(291, 68);
            this.AccountSettingsItem.Text = "Account Settings";
            // 
            // CurrentUserInfoItem
            // 
            this.CurrentUserInfoItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.CurrentUserInfoItem.Image = global::CRMS.Properties.Resources.PersonDetails_32;
            this.CurrentUserInfoItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.CurrentUserInfoItem.Name = "CurrentUserInfoItem";
            this.CurrentUserInfoItem.Size = new System.Drawing.Size(257, 42);
            this.CurrentUserInfoItem.Text = "Current User Info";
            this.CurrentUserInfoItem.Click += new System.EventHandler(this.CurrentUserInfoItem_Click);
            // 
            // ChangePasswordItem
            // 
            this.ChangePasswordItem.Font = new System.Drawing.Font("Segoe UI", 15F);
            this.ChangePasswordItem.Image = global::CRMS.Properties.Resources.Password_32;
            this.ChangePasswordItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.ChangePasswordItem.Name = "ChangePasswordItem";
            this.ChangePasswordItem.Size = new System.Drawing.Size(257, 42);
            this.ChangePasswordItem.Text = "Change Password";
            this.ChangePasswordItem.Click += new System.EventHandler(this.ChangePasswordItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(254, 6);
            // 
            // SignOutItem
            // 
            this.SignOutItem.Image = global::CRMS.Properties.Resources.sign_out_32__2;
            this.SignOutItem.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.SignOutItem.Name = "SignOutItem";
            this.SignOutItem.Size = new System.Drawing.Size(257, 42);
            this.SignOutItem.Text = "Sign Out";
            this.SignOutItem.Click += new System.EventHandler(this.SignOutItem_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.Black;
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBox1.Location = new System.Drawing.Point(0, 72);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(1370, 677);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.Color.Black;
            this.label1.Font = new System.Drawing.Font("Tahoma", 50F);
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(455, 182);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(461, 384);
            this.label1.TabIndex = 6;
            this.label1.Text = "Cars Rental Management System";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1370, 749);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.menuStrip);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.IsMdiContainer = true;
            this.MaximizeBox = false;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Cars Rental Management System";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.frmMain_FormClosed);
            this.menuStrip.ResumeLayout(false);
            this.menuStrip.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.MenuStrip menuStrip;
        private System.Windows.Forms.ToolStripMenuItem ApplicationsItem;
        private System.Windows.Forms.ToolStripMenuItem PeopleItem;
        private System.Windows.Forms.ToolStripMenuItem CustomersItem;
        private System.Windows.Forms.ToolStripMenuItem VehiclesItem;
        private System.Windows.Forms.ToolStripMenuItem UsersItem;
        private System.Windows.Forms.ToolStripMenuItem AccountSettingsItem;
        private System.Windows.Forms.ToolStripMenuItem CurrentUserInfoItem;
        private System.Windows.Forms.ToolStripMenuItem ChangePasswordItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem SignOutItem;
        private System.Windows.Forms.ToolStripMenuItem ManagementVehiclesItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem ManagementMakesItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripMenuItem ManagementMakeModelsItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator4;
        private System.Windows.Forms.ToolStripMenuItem ManagementFuelTypesItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator5;
        private System.Windows.Forms.ToolStripMenuItem ManagementCategoriesItem;
        private System.Windows.Forms.ToolStripMenuItem ManagementRentalBookingItem;
        private System.Windows.Forms.ToolStripMenuItem AddNewBookingItem;
        private System.Windows.Forms.ToolStripMenuItem ManagementRentalsBookingItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator6;
        private System.Windows.Forms.ToolStripMenuItem ManagementVehicleReturnItem;
        private System.Windows.Forms.ToolStripMenuItem VehicleReturnItem;
        private System.Windows.Forms.ToolStripMenuItem ManagementVehiclesReturnItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator7;
        private System.Windows.Forms.ToolStripMenuItem ManagementRentalsTransactionItem;
        private System.Windows.Forms.Label label1;
    }
}

