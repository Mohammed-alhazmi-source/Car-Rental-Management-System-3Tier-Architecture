namespace CRMS.Vehicle
{
    partial class frmAddUpdateRentalBooking
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAddUpdateRentalBooking));
            this.tcRentalBooking = new System.Windows.Forms.TabControl();
            this.tpCustomerInfo = new System.Windows.Forms.TabPage();
            this.btnNextTab = new System.Windows.Forms.Button();
            this.ctrlCustomerCardWithFilter1 = new CRMS.Customer.Controls.ctrlCustomerCardWithFilter();
            this.tpVehicleInfo = new System.Windows.Forms.TabPage();
            this.btnNextTabBooking = new System.Windows.Forms.Button();
            this.ctrlVehicleCardWithFilter1 = new CRMS.Vehicle.Controls.ctrlVehicleCardWithFilter();
            this.tpRentalBookingInfo = new System.Windows.Forms.TabPage();
            this.btnSetBooking = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.lblBookingID = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.label7 = new System.Windows.Forms.Label();
            this.txtPaymentDetails = new System.Windows.Forms.TextBox();
            this.lblInitialTotalDueAmount = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.txtRentalPricePerDay = new System.Windows.Forms.TextBox();
            this.nudInitialRentalDays = new System.Windows.Forms.NumericUpDown();
            this.dtpRentalEndDate = new System.Windows.Forms.DateTimePicker();
            this.dtpRentalStartDate = new System.Windows.Forms.DateTimePicker();
            this.label10 = new System.Windows.Forms.Label();
            this.txtInitialCheckNotes = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txtDropOfLocation = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtPickupLocation = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.lblTitle = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.tcRentalBooking.SuspendLayout();
            this.tpCustomerInfo.SuspendLayout();
            this.tpVehicleInfo.SuspendLayout();
            this.tpRentalBookingInfo.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInitialRentalDays)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // tcRentalBooking
            // 
            this.tcRentalBooking.Controls.Add(this.tpCustomerInfo);
            this.tcRentalBooking.Controls.Add(this.tpVehicleInfo);
            this.tcRentalBooking.Controls.Add(this.tpRentalBookingInfo);
            this.tcRentalBooking.Font = new System.Drawing.Font("Tahoma", 15F);
            this.tcRentalBooking.Location = new System.Drawing.Point(27, 60);
            this.tcRentalBooking.Name = "tcRentalBooking";
            this.tcRentalBooking.SelectedIndex = 0;
            this.tcRentalBooking.Size = new System.Drawing.Size(1203, 511);
            this.tcRentalBooking.TabIndex = 0;
            // 
            // tpCustomerInfo
            // 
            this.tpCustomerInfo.BackColor = System.Drawing.Color.White;
            this.tpCustomerInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpCustomerInfo.Controls.Add(this.btnNextTab);
            this.tpCustomerInfo.Controls.Add(this.ctrlCustomerCardWithFilter1);
            this.tpCustomerInfo.Location = new System.Drawing.Point(4, 33);
            this.tpCustomerInfo.Name = "tpCustomerInfo";
            this.tpCustomerInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpCustomerInfo.Size = new System.Drawing.Size(1195, 474);
            this.tpCustomerInfo.TabIndex = 0;
            this.tpCustomerInfo.Text = "Customer Info";
            // 
            // btnNextTab
            // 
            this.btnNextTab.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextTab.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextTab.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextTab.Location = new System.Drawing.Point(1015, 422);
            this.btnNextTab.Name = "btnNextTab";
            this.btnNextTab.Size = new System.Drawing.Size(172, 33);
            this.btnNextTab.TabIndex = 1;
            this.btnNextTab.Text = "Next";
            this.btnNextTab.UseVisualStyleBackColor = true;
            this.btnNextTab.Click += new System.EventHandler(this.btnNextTab_Click);
            // 
            // ctrlCustomerCardWithFilter1
            // 
            this.ctrlCustomerCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlCustomerCardWithFilter1.FilterEnabled = true;
            this.ctrlCustomerCardWithFilter1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlCustomerCardWithFilter1.Location = new System.Drawing.Point(89, 24);
            this.ctrlCustomerCardWithFilter1.Margin = new System.Windows.Forms.Padding(6);
            this.ctrlCustomerCardWithFilter1.Name = "ctrlCustomerCardWithFilter1";
            this.ctrlCustomerCardWithFilter1.Size = new System.Drawing.Size(1014, 365);
            this.ctrlCustomerCardWithFilter1.TabIndex = 0;
            this.ctrlCustomerCardWithFilter1.OnSelectedCustomer += new System.Action<int>(this.ctrlCustomerCardWithFilter1_OnSelectedCustomer);
            // 
            // tpVehicleInfo
            // 
            this.tpVehicleInfo.BackColor = System.Drawing.Color.White;
            this.tpVehicleInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpVehicleInfo.Controls.Add(this.btnNextTabBooking);
            this.tpVehicleInfo.Controls.Add(this.ctrlVehicleCardWithFilter1);
            this.tpVehicleInfo.Location = new System.Drawing.Point(4, 33);
            this.tpVehicleInfo.Name = "tpVehicleInfo";
            this.tpVehicleInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpVehicleInfo.Size = new System.Drawing.Size(1195, 474);
            this.tpVehicleInfo.TabIndex = 2;
            this.tpVehicleInfo.Text = "Vehicle Info";
            // 
            // btnNextTabBooking
            // 
            this.btnNextTabBooking.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextTabBooking.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextTabBooking.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextTabBooking.Location = new System.Drawing.Point(974, 423);
            this.btnNextTabBooking.Name = "btnNextTabBooking";
            this.btnNextTabBooking.Size = new System.Drawing.Size(172, 40);
            this.btnNextTabBooking.TabIndex = 6;
            this.btnNextTabBooking.Text = "Next";
            this.btnNextTabBooking.UseVisualStyleBackColor = true;
            this.btnNextTabBooking.Click += new System.EventHandler(this.btnNextTabBooking_Click);
            // 
            // ctrlVehicleCardWithFilter1
            // 
            this.ctrlVehicleCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlVehicleCardWithFilter1.FilterEnabled = true;
            this.ctrlVehicleCardWithFilter1.Font = new System.Drawing.Font("Symbol", 7F);
            this.ctrlVehicleCardWithFilter1.Location = new System.Drawing.Point(-5, 24);
            this.ctrlVehicleCardWithFilter1.Margin = new System.Windows.Forms.Padding(6);
            this.ctrlVehicleCardWithFilter1.Name = "ctrlVehicleCardWithFilter1";
            this.ctrlVehicleCardWithFilter1.Size = new System.Drawing.Size(1182, 439);
            this.ctrlVehicleCardWithFilter1.TabIndex = 0;
            this.ctrlVehicleCardWithFilter1.VisibleButtonAddVehicle = true;
            this.ctrlVehicleCardWithFilter1.OnVehicleSelected += new System.EventHandler<CRMS.Vehicle.Controls.ctrlVehicleCardWithFilter.VehicleSelectedEventArgs>(this.ctrlVehicleCardWithFilter1_OnVehicleSelected);
            // 
            // tpRentalBookingInfo
            // 
            this.tpRentalBookingInfo.BackColor = System.Drawing.Color.White;
            this.tpRentalBookingInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpRentalBookingInfo.Controls.Add(this.btnSetBooking);
            this.tpRentalBookingInfo.Controls.Add(this.panel1);
            this.tpRentalBookingInfo.Controls.Add(this.panel2);
            this.tpRentalBookingInfo.Location = new System.Drawing.Point(4, 33);
            this.tpRentalBookingInfo.Name = "tpRentalBookingInfo";
            this.tpRentalBookingInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpRentalBookingInfo.Size = new System.Drawing.Size(1195, 474);
            this.tpRentalBookingInfo.TabIndex = 1;
            this.tpRentalBookingInfo.Text = "Rental Booking Info";
            // 
            // btnSetBooking
            // 
            this.btnSetBooking.Enabled = false;
            this.btnSetBooking.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSetBooking.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnSetBooking.Location = new System.Drawing.Point(996, 421);
            this.btnSetBooking.Name = "btnSetBooking";
            this.btnSetBooking.Size = new System.Drawing.Size(172, 42);
            this.btnSetBooking.TabIndex = 26;
            this.btnSetBooking.Text = "Set Booking";
            this.btnSetBooking.UseVisualStyleBackColor = true;
            this.btnSetBooking.Click += new System.EventHandler(this.btnSetBooking_Click);
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.lblBookingID);
            this.panel1.Controls.Add(this.pictureBox1);
            this.panel1.Location = new System.Drawing.Point(228, 19);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(737, 58);
            this.panel1.TabIndex = 22;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(16, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 19);
            this.label1.TabIndex = 11;
            this.label1.Text = "Booking ID:";
            // 
            // lblBookingID
            // 
            this.lblBookingID.AutoSize = true;
            this.lblBookingID.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.lblBookingID.ForeColor = System.Drawing.Color.Black;
            this.lblBookingID.Location = new System.Drawing.Point(166, 17);
            this.lblBookingID.Name = "lblBookingID";
            this.lblBookingID.Size = new System.Drawing.Size(50, 19);
            this.lblBookingID.TabIndex = 13;
            this.lblBookingID.Text = "[???]";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(127, 13);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(33, 30);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 12;
            this.pictureBox1.TabStop = false;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.label7);
            this.panel2.Controls.Add(this.txtPaymentDetails);
            this.panel2.Controls.Add(this.lblInitialTotalDueAmount);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.txtRentalPricePerDay);
            this.panel2.Controls.Add(this.nudInitialRentalDays);
            this.panel2.Controls.Add(this.dtpRentalEndDate);
            this.panel2.Controls.Add(this.dtpRentalStartDate);
            this.panel2.Controls.Add(this.label10);
            this.panel2.Controls.Add(this.txtInitialCheckNotes);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.txtDropOfLocation);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.txtPickupLocation);
            this.panel2.Controls.Add(this.label15);
            this.panel2.Controls.Add(this.label14);
            this.panel2.Location = new System.Drawing.Point(228, 80);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(737, 383);
            this.panel2.TabIndex = 23;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label7.ForeColor = System.Drawing.Color.Black;
            this.label7.Location = new System.Drawing.Point(25, 219);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(143, 19);
            this.label7.TabIndex = 73;
            this.label7.Text = "Payment Details";
            // 
            // txtPaymentDetails
            // 
            this.txtPaymentDetails.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtPaymentDetails.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPaymentDetails.Location = new System.Drawing.Point(20, 240);
            this.txtPaymentDetails.MaxLength = 20;
            this.txtPaymentDetails.Multiline = true;
            this.txtPaymentDetails.Name = "txtPaymentDetails";
            this.txtPaymentDetails.Size = new System.Drawing.Size(335, 36);
            this.txtPaymentDetails.TabIndex = 72;
            this.txtPaymentDetails.Validating += new System.ComponentModel.CancelEventHandler(this.txtPaymentDetails_Validating);
            // 
            // lblInitialTotalDueAmount
            // 
            this.lblInitialTotalDueAmount.AutoSize = true;
            this.lblInitialTotalDueAmount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblInitialTotalDueAmount.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblInitialTotalDueAmount.Location = new System.Drawing.Point(644, 246);
            this.lblInitialTotalDueAmount.Name = "lblInitialTotalDueAmount";
            this.lblInitialTotalDueAmount.Size = new System.Drawing.Size(45, 19);
            this.lblInitialTotalDueAmount.TabIndex = 71;
            this.lblInitialTotalDueAmount.Text = "[???]";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label6.ForeColor = System.Drawing.Color.Black;
            this.label6.Location = new System.Drawing.Point(425, 246);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(218, 19);
            this.label6.TabIndex = 70;
            this.label6.Text = "Initial Total Due Amount:";
            // 
            // txtRentalPricePerDay
            // 
            this.txtRentalPricePerDay.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtRentalPricePerDay.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRentalPricePerDay.Location = new System.Drawing.Point(382, 174);
            this.txtRentalPricePerDay.MaxLength = 20;
            this.txtRentalPricePerDay.Multiline = true;
            this.txtRentalPricePerDay.Name = "txtRentalPricePerDay";
            this.txtRentalPricePerDay.ReadOnly = true;
            this.txtRentalPricePerDay.Size = new System.Drawing.Size(335, 36);
            this.txtRentalPricePerDay.TabIndex = 3;
            this.txtRentalPricePerDay.Validating += new System.ComponentModel.CancelEventHandler(this.txtRentalPricePerDay_Validating);
            // 
            // nudInitialRentalDays
            // 
            this.nudInitialRentalDays.Location = new System.Drawing.Point(20, 178);
            this.nudInitialRentalDays.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudInitialRentalDays.Name = "nudInitialRentalDays";
            this.nudInitialRentalDays.Size = new System.Drawing.Size(335, 32);
            this.nudInitialRentalDays.TabIndex = 2;
            this.nudInitialRentalDays.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudInitialRentalDays.ValueChanged += new System.EventHandler(this.nudInitialRentalDays_ValueChanged);
            // 
            // dtpRentalEndDate
            // 
            this.dtpRentalEndDate.Checked = false;
            this.dtpRentalEndDate.Enabled = false;
            this.dtpRentalEndDate.Font = new System.Drawing.Font("Tahoma", 18F);
            this.dtpRentalEndDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpRentalEndDate.Location = new System.Drawing.Point(382, 35);
            this.dtpRentalEndDate.Name = "dtpRentalEndDate";
            this.dtpRentalEndDate.Size = new System.Drawing.Size(335, 36);
            this.dtpRentalEndDate.TabIndex = 66;
            this.dtpRentalEndDate.ValueChanged += new System.EventHandler(this.dtpRentalEndDate_ValueChanged);
            // 
            // dtpRentalStartDate
            // 
            this.dtpRentalStartDate.Enabled = false;
            this.dtpRentalStartDate.Font = new System.Drawing.Font("Tahoma", 18F);
            this.dtpRentalStartDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpRentalStartDate.Location = new System.Drawing.Point(20, 35);
            this.dtpRentalStartDate.Name = "dtpRentalStartDate";
            this.dtpRentalStartDate.Size = new System.Drawing.Size(335, 36);
            this.dtpRentalStartDate.TabIndex = 65;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label10.ForeColor = System.Drawing.Color.Black;
            this.label10.Location = new System.Drawing.Point(24, 285);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(164, 19);
            this.label10.TabIndex = 64;
            this.label10.Text = "Initial Check Notes";
            // 
            // txtInitialCheckNotes
            // 
            this.txtInitialCheckNotes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtInitialCheckNotes.Font = new System.Drawing.Font("Tahoma", 12F);
            this.txtInitialCheckNotes.Location = new System.Drawing.Point(19, 307);
            this.txtInitialCheckNotes.MaxLength = 50;
            this.txtInitialCheckNotes.Multiline = true;
            this.txtInitialCheckNotes.Name = "txtInitialCheckNotes";
            this.txtInitialCheckNotes.Size = new System.Drawing.Size(698, 67);
            this.txtInitialCheckNotes.TabIndex = 4;
            this.txtInitialCheckNotes.Validating += new System.ComponentModel.CancelEventHandler(this.txtInitialCheckNotes_Validating);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label5.ForeColor = System.Drawing.Color.Black;
            this.label5.Location = new System.Drawing.Point(387, 154);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(178, 19);
            this.label5.TabIndex = 54;
            this.label5.Text = "Rental Price Per Day";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label4.ForeColor = System.Drawing.Color.Black;
            this.label4.Location = new System.Drawing.Point(24, 154);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(161, 19);
            this.label4.TabIndex = 53;
            this.label4.Text = "Initial Rental Days";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(387, 85);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(145, 19);
            this.label3.TabIndex = 51;
            this.label3.Text = "Drop Of Location";
            // 
            // txtDropOfLocation
            // 
            this.txtDropOfLocation.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtDropOfLocation.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtDropOfLocation.Location = new System.Drawing.Point(382, 106);
            this.txtDropOfLocation.MaxLength = 20;
            this.txtDropOfLocation.Multiline = true;
            this.txtDropOfLocation.Name = "txtDropOfLocation";
            this.txtDropOfLocation.Size = new System.Drawing.Size(335, 36);
            this.txtDropOfLocation.TabIndex = 1;
            this.txtDropOfLocation.Validating += new System.ComponentModel.CancelEventHandler(this.txtDropOfLocation_Validating);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label2.ForeColor = System.Drawing.Color.Black;
            this.label2.Location = new System.Drawing.Point(24, 85);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(137, 19);
            this.label2.TabIndex = 49;
            this.label2.Text = "Pickup Location";
            // 
            // txtPickupLocation
            // 
            this.txtPickupLocation.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtPickupLocation.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPickupLocation.Location = new System.Drawing.Point(19, 106);
            this.txtPickupLocation.MaxLength = 20;
            this.txtPickupLocation.Multiline = true;
            this.txtPickupLocation.Name = "txtPickupLocation";
            this.txtPickupLocation.Size = new System.Drawing.Size(335, 36);
            this.txtPickupLocation.TabIndex = 0;
            this.txtPickupLocation.Validating += new System.ComponentModel.CancelEventHandler(this.txtPickupLocation_Validating);
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label15.ForeColor = System.Drawing.Color.Black;
            this.label15.Location = new System.Drawing.Point(389, 11);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(142, 19);
            this.label15.TabIndex = 47;
            this.label15.Text = "Rental End Date";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label14.ForeColor = System.Drawing.Color.Black;
            this.label14.Location = new System.Drawing.Point(24, 11);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(153, 19);
            this.label14.TabIndex = 11;
            this.label14.Text = "Rental Start Date";
            // 
            // lblTitle
            // 
            this.lblTitle.Font = new System.Drawing.Font("Tahoma", 25F);
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblTitle.Location = new System.Drawing.Point(367, 13);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(508, 44);
            this.lblTitle.TabIndex = 1;
            this.lblTitle.Text = "Title";
            this.lblTitle.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // frmAddUpdateRentalBooking
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1242, 611);
            this.Controls.Add(this.tcRentalBooking);
            this.Controls.Add(this.lblTitle);
            this.MaximizeBox = false;
            this.Name = "frmAddUpdateRentalBooking";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Rental Booking";
            this.Activated += new System.EventHandler(this.frmRentalBooking_Activated);
            this.Load += new System.EventHandler(this.frmRentalBooking_Load);
            this.tcRentalBooking.ResumeLayout(false);
            this.tpCustomerInfo.ResumeLayout(false);
            this.tpVehicleInfo.ResumeLayout(false);
            this.tpRentalBookingInfo.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInitialRentalDays)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tcRentalBooking;
        private System.Windows.Forms.TabPage tpCustomerInfo;
        private System.Windows.Forms.TabPage tpRentalBookingInfo;
        private System.Windows.Forms.TabPage tpVehicleInfo;
        private Customer.Controls.ctrlCustomerCardWithFilter ctrlCustomerCardWithFilter1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.Label lblBookingID;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtInitialCheckNotes;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtDropOfLocation;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtPickupLocation;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.DateTimePicker dtpRentalStartDate;
        private System.Windows.Forms.DateTimePicker dtpRentalEndDate;
        private System.Windows.Forms.TextBox txtRentalPricePerDay;
        private System.Windows.Forms.NumericUpDown nudInitialRentalDays;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label lblTitle;
        private Controls.ctrlVehicleCardWithFilter ctrlVehicleCardWithFilter1;
        private System.Windows.Forms.Button btnNextTab;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.Label lblInitialTotalDueAmount;
        private System.Windows.Forms.Button btnSetBooking;
        private System.Windows.Forms.Button btnNextTabBooking;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtPaymentDetails;
    }
}