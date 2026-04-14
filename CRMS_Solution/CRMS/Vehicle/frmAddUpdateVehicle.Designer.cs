namespace CRMS.Vehicle
{
    partial class frmAddUpdateVehicle
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAddUpdateVehicle));
            this.tcVehicle = new System.Windows.Forms.TabControl();
            this.tpMakeInfo = new System.Windows.Forms.TabPage();
            this.btnNextTab = new System.Windows.Forms.Button();
            this.ctrlMakeCardWithFilter1 = new CRMS.Make.Controls.ctrlMakeCardWithFilter();
            this.tpVehicleInfo = new System.Windows.Forms.TabPage();
            this.panel3 = new System.Windows.Forms.Panel();
            this.btnRemoveImage = new System.Windows.Forms.Button();
            this.btnChooseImage = new System.Windows.Forms.Button();
            this.pbVehicleImage = new System.Windows.Forms.PictureBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txtRentalPricePerDay = new System.Windows.Forms.TextBox();
            this.cbCategories = new System.Windows.Forms.ComboBox();
            this.txtPlateNumber = new System.Windows.Forms.TextBox();
            this.cbFuelTypes = new System.Windows.Forms.ComboBox();
            this.cbModels = new System.Windows.Forms.ComboBox();
            this.lblMakeName = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txtMileage = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtYear = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.lblVehicleID = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.lblTitle = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.btnSave = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.tcVehicle.SuspendLayout();
            this.tpMakeInfo.SuspendLayout();
            this.tpVehicleInfo.SuspendLayout();
            this.panel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbVehicleImage)).BeginInit();
            this.panel2.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // tcVehicle
            // 
            this.tcVehicle.Controls.Add(this.tpMakeInfo);
            this.tcVehicle.Controls.Add(this.tpVehicleInfo);
            this.tcVehicle.Font = new System.Drawing.Font("Tahoma", 13F);
            this.tcVehicle.Location = new System.Drawing.Point(23, 27);
            this.tcVehicle.Name = "tcVehicle";
            this.tcVehicle.SelectedIndex = 0;
            this.tcVehicle.Size = new System.Drawing.Size(1062, 486);
            this.tcVehicle.TabIndex = 0;
            // 
            // tpMakeInfo
            // 
            this.tpMakeInfo.BackColor = System.Drawing.Color.White;
            this.tpMakeInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpMakeInfo.Controls.Add(this.btnNextTab);
            this.tpMakeInfo.Controls.Add(this.ctrlMakeCardWithFilter1);
            this.tpMakeInfo.Location = new System.Drawing.Point(4, 30);
            this.tpMakeInfo.Name = "tpMakeInfo";
            this.tpMakeInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpMakeInfo.Size = new System.Drawing.Size(1054, 452);
            this.tpMakeInfo.TabIndex = 0;
            this.tpMakeInfo.Text = "Make Info";
            // 
            // btnNextTab
            // 
            this.btnNextTab.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextTab.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextTab.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextTab.Location = new System.Drawing.Point(878, 390);
            this.btnNextTab.Name = "btnNextTab";
            this.btnNextTab.Size = new System.Drawing.Size(163, 43);
            this.btnNextTab.TabIndex = 1;
            this.btnNextTab.Text = "Next";
            this.btnNextTab.UseVisualStyleBackColor = true;
            this.btnNextTab.Click += new System.EventHandler(this.btnNextTab_Click);
            // 
            // ctrlMakeCardWithFilter1
            // 
            this.ctrlMakeCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCardWithFilter1.FilterEnabled = true;
            this.ctrlMakeCardWithFilter1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlMakeCardWithFilter1.Location = new System.Drawing.Point(126, 78);
            this.ctrlMakeCardWithFilter1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.ctrlMakeCardWithFilter1.Name = "ctrlMakeCardWithFilter1";
            this.ctrlMakeCardWithFilter1.Size = new System.Drawing.Size(801, 295);
            this.ctrlMakeCardWithFilter1.TabIndex = 0;
            this.ctrlMakeCardWithFilter1.OnMakeSelected += new System.EventHandler<CRMS.Make.Controls.ctrlMakeCardWithFilter.MakeSelectedEventArgs>(this.ctrlMakeCardWithFilter1_OnMakeSelected);
            // 
            // tpVehicleInfo
            // 
            this.tpVehicleInfo.BackColor = System.Drawing.Color.White;
            this.tpVehicleInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpVehicleInfo.Controls.Add(this.panel3);
            this.tpVehicleInfo.Controls.Add(this.panel2);
            this.tpVehicleInfo.Controls.Add(this.panel1);
            this.tpVehicleInfo.Location = new System.Drawing.Point(4, 30);
            this.tpVehicleInfo.Name = "tpVehicleInfo";
            this.tpVehicleInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpVehicleInfo.Size = new System.Drawing.Size(1054, 452);
            this.tpVehicleInfo.TabIndex = 1;
            this.tpVehicleInfo.Text = "Vehicle Info";
            // 
            // panel3
            // 
            this.panel3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel3.Controls.Add(this.btnRemoveImage);
            this.panel3.Controls.Add(this.btnChooseImage);
            this.panel3.Controls.Add(this.pbVehicleImage);
            this.panel3.Location = new System.Drawing.Point(791, 76);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(214, 368);
            this.panel3.TabIndex = 23;
            // 
            // btnRemoveImage
            // 
            this.btnRemoveImage.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRemoveImage.Font = new System.Drawing.Font("Tahoma", 15F);
            this.btnRemoveImage.Location = new System.Drawing.Point(24, 316);
            this.btnRemoveImage.Name = "btnRemoveImage";
            this.btnRemoveImage.Size = new System.Drawing.Size(165, 45);
            this.btnRemoveImage.TabIndex = 37;
            this.btnRemoveImage.Text = "Remove Image";
            this.btnRemoveImage.UseVisualStyleBackColor = true;
            this.btnRemoveImage.Click += new System.EventHandler(this.btnRemoveImage_Click);
            // 
            // btnChooseImage
            // 
            this.btnChooseImage.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnChooseImage.Font = new System.Drawing.Font("Tahoma", 15F);
            this.btnChooseImage.Location = new System.Drawing.Point(24, 265);
            this.btnChooseImage.Name = "btnChooseImage";
            this.btnChooseImage.Size = new System.Drawing.Size(165, 45);
            this.btnChooseImage.TabIndex = 36;
            this.btnChooseImage.Text = "Choose Image";
            this.btnChooseImage.UseVisualStyleBackColor = true;
            this.btnChooseImage.Click += new System.EventHandler(this.btnChooseImage_Click);
            // 
            // pbVehicleImage
            // 
            this.pbVehicleImage.BackColor = System.Drawing.Color.WhiteSmoke;
            this.pbVehicleImage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pbVehicleImage.Image = global::CRMS.Properties.Resources.wallpaper;
            this.pbVehicleImage.Location = new System.Drawing.Point(13, 6);
            this.pbVehicleImage.Name = "pbVehicleImage";
            this.pbVehicleImage.Size = new System.Drawing.Size(187, 252);
            this.pbVehicleImage.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbVehicleImage.TabIndex = 35;
            this.pbVehicleImage.TabStop = false;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.txtRentalPricePerDay);
            this.panel2.Controls.Add(this.cbCategories);
            this.panel2.Controls.Add(this.txtPlateNumber);
            this.panel2.Controls.Add(this.cbFuelTypes);
            this.panel2.Controls.Add(this.cbModels);
            this.panel2.Controls.Add(this.lblMakeName);
            this.panel2.Controls.Add(this.label7);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.txtMileage);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.txtYear);
            this.panel2.Controls.Add(this.label15);
            this.panel2.Controls.Add(this.label14);
            this.panel2.Font = new System.Drawing.Font("Tahoma", 8F);
            this.panel2.Location = new System.Drawing.Point(48, 76);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(737, 368);
            this.panel2.TabIndex = 22;
            // 
            // txtRentalPricePerDay
            // 
            this.txtRentalPricePerDay.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtRentalPricePerDay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRentalPricePerDay.Location = new System.Drawing.Point(382, 288);
            this.txtRentalPricePerDay.MaxLength = 20;
            this.txtRentalPricePerDay.Multiline = true;
            this.txtRentalPricePerDay.Name = "txtRentalPricePerDay";
            this.txtRentalPricePerDay.Size = new System.Drawing.Size(335, 36);
            this.txtRentalPricePerDay.TabIndex = 70;
            this.txtRentalPricePerDay.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtRentalPricePerDay_KeyPress);
            this.txtRentalPricePerDay.Validating += new System.ComponentModel.CancelEventHandler(this.txtRentalPricePerDay_Validating);
            // 
            // cbCategories
            // 
            this.cbCategories.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCategories.Font = new System.Drawing.Font("Tahoma", 17F);
            this.cbCategories.FormattingEnabled = true;
            this.cbCategories.Location = new System.Drawing.Point(19, 287);
            this.cbCategories.Name = "cbCategories";
            this.cbCategories.Size = new System.Drawing.Size(335, 36);
            this.cbCategories.TabIndex = 69;
            // 
            // txtPlateNumber
            // 
            this.txtPlateNumber.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtPlateNumber.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPlateNumber.Location = new System.Drawing.Point(382, 204);
            this.txtPlateNumber.MaxLength = 20;
            this.txtPlateNumber.Multiline = true;
            this.txtPlateNumber.Name = "txtPlateNumber";
            this.txtPlateNumber.Size = new System.Drawing.Size(335, 36);
            this.txtPlateNumber.TabIndex = 68;
            this.txtPlateNumber.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPlateNumber_KeyPress);
            this.txtPlateNumber.Validating += new System.ComponentModel.CancelEventHandler(this.txtPlateNumber_Validating);
            // 
            // cbFuelTypes
            // 
            this.cbFuelTypes.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFuelTypes.Font = new System.Drawing.Font("Tahoma", 17F);
            this.cbFuelTypes.FormattingEnabled = true;
            this.cbFuelTypes.Location = new System.Drawing.Point(19, 204);
            this.cbFuelTypes.Name = "cbFuelTypes";
            this.cbFuelTypes.Size = new System.Drawing.Size(335, 36);
            this.cbFuelTypes.TabIndex = 67;
            // 
            // cbModels
            // 
            this.cbModels.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbModels.Font = new System.Drawing.Font("Tahoma", 17F);
            this.cbModels.FormattingEnabled = true;
            this.cbModels.Location = new System.Drawing.Point(19, 121);
            this.cbModels.Name = "cbModels";
            this.cbModels.Size = new System.Drawing.Size(335, 36);
            this.cbModels.TabIndex = 66;
            // 
            // lblMakeName
            // 
            this.lblMakeName.AutoSize = true;
            this.lblMakeName.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.lblMakeName.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblMakeName.Location = new System.Drawing.Point(44, 35);
            this.lblMakeName.Name = "lblMakeName";
            this.lblMakeName.Size = new System.Drawing.Size(50, 19);
            this.lblMakeName.TabIndex = 65;
            this.lblMakeName.Text = "[???]";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label7.ForeColor = System.Drawing.Color.Black;
            this.label7.Location = new System.Drawing.Point(389, 266);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(178, 19);
            this.label7.TabIndex = 58;
            this.label7.Text = "Rental Price Per Day";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label6.ForeColor = System.Drawing.Color.Black;
            this.label6.Location = new System.Drawing.Point(24, 266);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(83, 19);
            this.label6.TabIndex = 56;
            this.label6.Text = "Category";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label5.ForeColor = System.Drawing.Color.Black;
            this.label5.Location = new System.Drawing.Point(387, 182);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(127, 19);
            this.label5.TabIndex = 54;
            this.label5.Text = "Plate Number:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label4.ForeColor = System.Drawing.Color.Black;
            this.label4.Location = new System.Drawing.Point(24, 182);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(88, 19);
            this.label4.TabIndex = 53;
            this.label4.Text = "Fuel Type";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(387, 99);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(73, 19);
            this.label3.TabIndex = 51;
            this.label3.Text = "Mileage";
            // 
            // txtMileage
            // 
            this.txtMileage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtMileage.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtMileage.Location = new System.Drawing.Point(382, 120);
            this.txtMileage.MaxLength = 20;
            this.txtMileage.Multiline = true;
            this.txtMileage.Name = "txtMileage";
            this.txtMileage.Size = new System.Drawing.Size(335, 36);
            this.txtMileage.TabIndex = 3;
            this.txtMileage.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtMileage_KeyPress);
            this.txtMileage.Validating += new System.ComponentModel.CancelEventHandler(this.txtMileage_Validating);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label2.ForeColor = System.Drawing.Color.Black;
            this.label2.Location = new System.Drawing.Point(389, 13);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(47, 19);
            this.label2.TabIndex = 49;
            this.label2.Text = "Year";
            // 
            // txtYear
            // 
            this.txtYear.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtYear.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtYear.Location = new System.Drawing.Point(382, 35);
            this.txtYear.MaxLength = 20;
            this.txtYear.Multiline = true;
            this.txtYear.Name = "txtYear";
            this.txtYear.Size = new System.Drawing.Size(335, 36);
            this.txtYear.TabIndex = 2;
            this.txtYear.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtYear_KeyPress);
            this.txtYear.Validating += new System.ComponentModel.CancelEventHandler(this.txtYear_Validating);
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label15.ForeColor = System.Drawing.Color.Black;
            this.label15.Location = new System.Drawing.Point(24, 99);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(66, 19);
            this.label15.TabIndex = 47;
            this.label15.Text = "Models";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label14.ForeColor = System.Drawing.Color.Black;
            this.label14.Location = new System.Drawing.Point(24, 11);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(111, 19);
            this.label14.TabIndex = 11;
            this.label14.Text = "Make Name:";
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.lblVehicleID);
            this.panel1.Controls.Add(this.pictureBox1);
            this.panel1.Location = new System.Drawing.Point(48, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(957, 58);
            this.panel1.TabIndex = 21;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(16, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(98, 19);
            this.label1.TabIndex = 11;
            this.label1.Text = "Vehicle ID:";
            // 
            // lblVehicleID
            // 
            this.lblVehicleID.AutoSize = true;
            this.lblVehicleID.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.lblVehicleID.ForeColor = System.Drawing.Color.Black;
            this.lblVehicleID.Location = new System.Drawing.Point(157, 17);
            this.lblVehicleID.Name = "lblVehicleID";
            this.lblVehicleID.Size = new System.Drawing.Size(50, 19);
            this.lblVehicleID.TabIndex = 13;
            this.lblVehicleID.Text = "[???]";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(114, 13);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(33, 30);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 12;
            this.pictureBox1.TabStop = false;
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Tahoma", 25F);
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblTitle.Location = new System.Drawing.Point(413, 6);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(271, 41);
            this.lblTitle.TabIndex = 18;
            this.lblTitle.Text = "Add New Vehicle";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // btnSave
            // 
            this.btnSave.Enabled = false;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnSave.Image = global::CRMS.Properties.Resources.Save_32;
            this.btnSave.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSave.Location = new System.Drawing.Point(907, 520);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(163, 43);
            this.btnSave.TabIndex = 2;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(738, 520);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(163, 43);
            this.btnClose.TabIndex = 3;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // frmAddUpdateVehicle
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(1109, 578);
            this.Controls.Add(this.lblTitle);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.tcVehicle);
            this.MaximizeBox = false;
            this.Name = "frmAddUpdateVehicle";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Add / Update Vehicle";
            this.Activated += new System.EventHandler(this.frmAddUpdateVehicle_Activated);
            this.Load += new System.EventHandler(this.frmAddUpdateVehicle_Load);
            this.tcVehicle.ResumeLayout(false);
            this.tpMakeInfo.ResumeLayout(false);
            this.tpVehicleInfo.ResumeLayout(false);
            this.panel3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pbVehicleImage)).EndInit();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TabControl tcVehicle;
        private System.Windows.Forms.TabPage tpMakeInfo;
        private System.Windows.Forms.TabPage tpVehicleInfo;
        private Make.Controls.ctrlMakeCardWithFilter ctrlMakeCardWithFilter1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.Label lblVehicleID;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.ComboBox cbModels;
        private System.Windows.Forms.Label lblMakeName;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtMileage;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtYear;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TextBox txtRentalPricePerDay;
        private System.Windows.Forms.ComboBox cbCategories;
        private System.Windows.Forms.TextBox txtPlateNumber;
        private System.Windows.Forms.ComboBox cbFuelTypes;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Button btnRemoveImage;
        private System.Windows.Forms.Button btnChooseImage;
        private System.Windows.Forms.PictureBox pbVehicleImage;
        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.Button btnNextTab;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnClose;
    }
}