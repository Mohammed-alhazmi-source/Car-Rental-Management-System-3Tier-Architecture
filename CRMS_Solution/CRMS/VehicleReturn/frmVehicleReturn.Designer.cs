namespace CRMS.VehicleReturn
{
    partial class frmVehicleReturn
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
            this.tcVehicleReturn = new System.Windows.Forms.TabControl();
            this.tpVehicleInfo = new System.Windows.Forms.TabPage();
            this.btnNextToRentalBookingInfo = new System.Windows.Forms.Button();
            this.ctrlVehicleCardWithFilter1 = new CRMS.Vehicle.Controls.ctrlVehicleCardWithFilter();
            this.tpRentalBookingInfo = new System.Windows.Forms.TabPage();
            this.btnNextToVehicleReturnInfo = new System.Windows.Forms.Button();
            this.ctrlRentalBookingCard1 = new CRMS.RentalBooking.Controls.ctrlRentalBookingCard();
            this.tpVehicleReturnInfo = new System.Windows.Forms.TabPage();
            this.llShowVehicleReturnInfo = new System.Windows.Forms.LinkLabel();
            this.btnSave = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.label11 = new System.Windows.Forms.Label();
            this.lblTotalRefundedAmount = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.lblTotalRemaining = new System.Windows.Forms.Label();
            this.nudInitialRentalDays = new System.Windows.Forms.NumericUpDown();
            this.txtAdditionalCharges = new System.Windows.Forms.TextBox();
            this.txtMileage = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.lblActualTotalDueAmount = new System.Windows.Forms.Label();
            this.txtFinalCheckNotes = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.dtpActualReturnDate = new System.Windows.Forms.DateTimePicker();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.lblConsumedMileage = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lblReturnID = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.tcVehicleReturn.SuspendLayout();
            this.tpVehicleInfo.SuspendLayout();
            this.tpRentalBookingInfo.SuspendLayout();
            this.tpVehicleReturnInfo.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInitialRentalDays)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // tcVehicleReturn
            // 
            this.tcVehicleReturn.Controls.Add(this.tpVehicleInfo);
            this.tcVehicleReturn.Controls.Add(this.tpRentalBookingInfo);
            this.tcVehicleReturn.Controls.Add(this.tpVehicleReturnInfo);
            this.tcVehicleReturn.Font = new System.Drawing.Font("Tahoma", 14F);
            this.tcVehicleReturn.Location = new System.Drawing.Point(12, 56);
            this.tcVehicleReturn.Name = "tcVehicleReturn";
            this.tcVehicleReturn.SelectedIndex = 0;
            this.tcVehicleReturn.Size = new System.Drawing.Size(1183, 580);
            this.tcVehicleReturn.TabIndex = 0;
            // 
            // tpVehicleInfo
            // 
            this.tpVehicleInfo.BackColor = System.Drawing.Color.White;
            this.tpVehicleInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpVehicleInfo.Controls.Add(this.btnNextToRentalBookingInfo);
            this.tpVehicleInfo.Controls.Add(this.ctrlVehicleCardWithFilter1);
            this.tpVehicleInfo.Location = new System.Drawing.Point(4, 32);
            this.tpVehicleInfo.Name = "tpVehicleInfo";
            this.tpVehicleInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpVehicleInfo.Size = new System.Drawing.Size(1175, 544);
            this.tpVehicleInfo.TabIndex = 0;
            this.tpVehicleInfo.Text = "Vehicle Info";
            // 
            // btnNextToRentalBookingInfo
            // 
            this.btnNextToRentalBookingInfo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextToRentalBookingInfo.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextToRentalBookingInfo.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextToRentalBookingInfo.Location = new System.Drawing.Point(967, 464);
            this.btnNextToRentalBookingInfo.Name = "btnNextToRentalBookingInfo";
            this.btnNextToRentalBookingInfo.Size = new System.Drawing.Size(181, 34);
            this.btnNextToRentalBookingInfo.TabIndex = 1;
            this.btnNextToRentalBookingInfo.Text = "Next";
            this.btnNextToRentalBookingInfo.UseVisualStyleBackColor = true;
            this.btnNextToRentalBookingInfo.Click += new System.EventHandler(this.btnNextToRentalBookingInfo_Click);
            // 
            // ctrlVehicleCardWithFilter1
            // 
            this.ctrlVehicleCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlVehicleCardWithFilter1.FilterEnabled = true;
            this.ctrlVehicleCardWithFilter1.Font = new System.Drawing.Font("SimSun-ExtB", 7F, System.Drawing.FontStyle.Bold);
            this.ctrlVehicleCardWithFilter1.Location = new System.Drawing.Point(-6, 90);
            this.ctrlVehicleCardWithFilter1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.ctrlVehicleCardWithFilter1.Name = "ctrlVehicleCardWithFilter1";
            this.ctrlVehicleCardWithFilter1.Size = new System.Drawing.Size(1151, 324);
            this.ctrlVehicleCardWithFilter1.TabIndex = 0;
            this.ctrlVehicleCardWithFilter1.VisibleButtonAddVehicle = false;
            this.ctrlVehicleCardWithFilter1.OnVehicleSelected += new System.EventHandler<CRMS.Vehicle.Controls.ctrlVehicleCardWithFilter.VehicleSelectedEventArgs>(this.ctrlVehicleCardWithFilter1_OnVehicleSelected);
            // 
            // tpRentalBookingInfo
            // 
            this.tpRentalBookingInfo.BackColor = System.Drawing.Color.White;
            this.tpRentalBookingInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpRentalBookingInfo.Controls.Add(this.btnNextToVehicleReturnInfo);
            this.tpRentalBookingInfo.Controls.Add(this.ctrlRentalBookingCard1);
            this.tpRentalBookingInfo.Location = new System.Drawing.Point(4, 32);
            this.tpRentalBookingInfo.Name = "tpRentalBookingInfo";
            this.tpRentalBookingInfo.Size = new System.Drawing.Size(1175, 544);
            this.tpRentalBookingInfo.TabIndex = 2;
            this.tpRentalBookingInfo.Text = "Rental Booking Info";
            // 
            // btnNextToVehicleReturnInfo
            // 
            this.btnNextToVehicleReturnInfo.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextToVehicleReturnInfo.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextToVehicleReturnInfo.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextToVehicleReturnInfo.Location = new System.Drawing.Point(927, 499);
            this.btnNextToVehicleReturnInfo.Name = "btnNextToVehicleReturnInfo";
            this.btnNextToVehicleReturnInfo.Size = new System.Drawing.Size(181, 34);
            this.btnNextToVehicleReturnInfo.TabIndex = 2;
            this.btnNextToVehicleReturnInfo.Text = "Next";
            this.btnNextToVehicleReturnInfo.UseVisualStyleBackColor = true;
            this.btnNextToVehicleReturnInfo.Click += new System.EventHandler(this.btnNextToVehicleReturnInfo_Click);
            // 
            // ctrlRentalBookingCard1
            // 
            this.ctrlRentalBookingCard1.BackColor = System.Drawing.Color.White;
            this.ctrlRentalBookingCard1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlRentalBookingCard1.Location = new System.Drawing.Point(10, -5);
            this.ctrlRentalBookingCard1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.ctrlRentalBookingCard1.Name = "ctrlRentalBookingCard1";
            this.ctrlRentalBookingCard1.Size = new System.Drawing.Size(1138, 498);
            this.ctrlRentalBookingCard1.TabIndex = 0;
            this.ctrlRentalBookingCard1.OnBookingChanged += new System.Action<int>(this.ctrlRentalBookingCard1_OnBookingChanged);
            // 
            // tpVehicleReturnInfo
            // 
            this.tpVehicleReturnInfo.BackColor = System.Drawing.Color.White;
            this.tpVehicleReturnInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpVehicleReturnInfo.Controls.Add(this.llShowVehicleReturnInfo);
            this.tpVehicleReturnInfo.Controls.Add(this.btnSave);
            this.tpVehicleReturnInfo.Controls.Add(this.panel2);
            this.tpVehicleReturnInfo.Controls.Add(this.panel1);
            this.tpVehicleReturnInfo.Location = new System.Drawing.Point(4, 32);
            this.tpVehicleReturnInfo.Name = "tpVehicleReturnInfo";
            this.tpVehicleReturnInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpVehicleReturnInfo.Size = new System.Drawing.Size(1175, 544);
            this.tpVehicleReturnInfo.TabIndex = 1;
            this.tpVehicleReturnInfo.Text = "Vehicle Return Info";
            // 
            // llShowVehicleReturnInfo
            // 
            this.llShowVehicleReturnInfo.AutoSize = true;
            this.llShowVehicleReturnInfo.Enabled = false;
            this.llShowVehicleReturnInfo.Location = new System.Drawing.Point(50, 491);
            this.llShowVehicleReturnInfo.Name = "llShowVehicleReturnInfo";
            this.llShowVehicleReturnInfo.Size = new System.Drawing.Size(230, 23);
            this.llShowVehicleReturnInfo.TabIndex = 18;
            this.llShowVehicleReturnInfo.TabStop = true;
            this.llShowVehicleReturnInfo.Text = "Show Vehicle Return Info.";
            this.llShowVehicleReturnInfo.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.llShowVehicleReturnInfo_LinkClicked);
            // 
            // btnSave
            // 
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Image = global::CRMS.Properties.Resources.Save_32;
            this.btnSave.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSave.Location = new System.Drawing.Point(962, 485);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(181, 34);
            this.btnSave.TabIndex = 16;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.label11);
            this.panel2.Controls.Add(this.lblTotalRefundedAmount);
            this.panel2.Controls.Add(this.label10);
            this.panel2.Controls.Add(this.lblTotalRemaining);
            this.panel2.Controls.Add(this.nudInitialRentalDays);
            this.panel2.Controls.Add(this.txtAdditionalCharges);
            this.panel2.Controls.Add(this.txtMileage);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.label7);
            this.panel2.Controls.Add(this.lblActualTotalDueAmount);
            this.panel2.Controls.Add(this.txtFinalCheckNotes);
            this.panel2.Controls.Add(this.label8);
            this.panel2.Controls.Add(this.dtpActualReturnDate);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Controls.Add(this.lblConsumedMileage);
            this.panel2.Location = new System.Drawing.Point(172, 175);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(829, 283);
            this.panel2.TabIndex = 17;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label11.Location = new System.Drawing.Point(443, 120);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(137, 22);
            this.label11.TabIndex = 17;
            this.label11.Text = "Total Refunded:";
            // 
            // lblTotalRefundedAmount
            // 
            this.lblTotalRefundedAmount.AutoSize = true;
            this.lblTotalRefundedAmount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblTotalRefundedAmount.Location = new System.Drawing.Point(591, 123);
            this.lblTotalRefundedAmount.Name = "lblTotalRefundedAmount";
            this.lblTotalRefundedAmount.Size = new System.Drawing.Size(45, 19);
            this.lblTotalRefundedAmount.TabIndex = 18;
            this.lblTotalRefundedAmount.Text = "[???]";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label10.Location = new System.Drawing.Point(443, 88);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(144, 22);
            this.label10.TabIndex = 15;
            this.label10.Text = "Total Remaining:";
            // 
            // lblTotalRemaining
            // 
            this.lblTotalRemaining.AutoSize = true;
            this.lblTotalRemaining.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblTotalRemaining.Location = new System.Drawing.Point(591, 91);
            this.lblTotalRemaining.Name = "lblTotalRemaining";
            this.lblTotalRemaining.Size = new System.Drawing.Size(45, 19);
            this.lblTotalRemaining.TabIndex = 16;
            this.lblTotalRemaining.Text = "[???]";
            // 
            // nudInitialRentalDays
            // 
            this.nudInitialRentalDays.Enabled = false;
            this.nudInitialRentalDays.Location = new System.Drawing.Point(609, 12);
            this.nudInitialRentalDays.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudInitialRentalDays.Name = "nudInitialRentalDays";
            this.nudInitialRentalDays.Size = new System.Drawing.Size(102, 30);
            this.nudInitialRentalDays.TabIndex = 0;
            this.nudInitialRentalDays.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudInitialRentalDays.ValueChanged += new System.EventHandler(this.nudInitialRentalDays_ValueChanged);
            // 
            // txtAdditionalCharges
            // 
            this.txtAdditionalCharges.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtAdditionalCharges.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtAdditionalCharges.Location = new System.Drawing.Point(183, 97);
            this.txtAdditionalCharges.MaxLength = 8;
            this.txtAdditionalCharges.Name = "txtAdditionalCharges";
            this.txtAdditionalCharges.Size = new System.Drawing.Size(179, 28);
            this.txtAdditionalCharges.TabIndex = 2;
            this.txtAdditionalCharges.Text = "0";
            this.txtAdditionalCharges.TextChanged += new System.EventHandler(this.txtAdditionalCharges_TextChanged);
            this.txtAdditionalCharges.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtAdditionalCharges_KeyPress);
            this.txtAdditionalCharges.Validating += new System.ComponentModel.CancelEventHandler(this.txtAdditionalCharges_Validating);
            // 
            // txtMileage
            // 
            this.txtMileage.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtMileage.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtMileage.Location = new System.Drawing.Point(183, 52);
            this.txtMileage.MaxLength = 7;
            this.txtMileage.Name = "txtMileage";
            this.txtMileage.Size = new System.Drawing.Size(179, 28);
            this.txtMileage.TabIndex = 1;
            this.txtMileage.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtMileage_KeyPress);
            this.txtMileage.Validating += new System.ComponentModel.CancelEventHandler(this.txtMileage_Validating);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label2.Location = new System.Drawing.Point(18, 16);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(164, 22);
            this.label2.TabIndex = 2;
            this.label2.Text = "Actual Return Date:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label7.Location = new System.Drawing.Point(443, 152);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(215, 22);
            this.label7.TabIndex = 12;
            this.label7.Text = "Actual Total Due Amount:";
            // 
            // lblActualTotalDueAmount
            // 
            this.lblActualTotalDueAmount.AutoSize = true;
            this.lblActualTotalDueAmount.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblActualTotalDueAmount.Location = new System.Drawing.Point(657, 153);
            this.lblActualTotalDueAmount.Name = "lblActualTotalDueAmount";
            this.lblActualTotalDueAmount.Size = new System.Drawing.Size(45, 19);
            this.lblActualTotalDueAmount.TabIndex = 13;
            this.lblActualTotalDueAmount.Text = "[???]";
            // 
            // txtFinalCheckNotes
            // 
            this.txtFinalCheckNotes.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFinalCheckNotes.Font = new System.Drawing.Font("Tahoma", 13F);
            this.txtFinalCheckNotes.Location = new System.Drawing.Point(22, 201);
            this.txtFinalCheckNotes.Multiline = true;
            this.txtFinalCheckNotes.Name = "txtFinalCheckNotes";
            this.txtFinalCheckNotes.Size = new System.Drawing.Size(791, 68);
            this.txtFinalCheckNotes.TabIndex = 3;
            this.txtFinalCheckNotes.Validating += new System.ComponentModel.CancelEventHandler(this.txtFinalCheckNotes_Validating);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label8.Location = new System.Drawing.Point(21, 173);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(156, 22);
            this.label8.TabIndex = 14;
            this.label8.Text = "Final Check Notes:";
            // 
            // dtpActualReturnDate
            // 
            this.dtpActualReturnDate.Font = new System.Drawing.Font("Tahoma", 12F);
            this.dtpActualReturnDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpActualReturnDate.Location = new System.Drawing.Point(183, 16);
            this.dtpActualReturnDate.Name = "dtpActualReturnDate";
            this.dtpActualReturnDate.Size = new System.Drawing.Size(179, 27);
            this.dtpActualReturnDate.TabIndex = 4;
            this.dtpActualReturnDate.ValueChanged += new System.EventHandler(this.dtpActualReturnDate_ValueChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label3.Location = new System.Drawing.Point(443, 16);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(163, 22);
            this.label3.TabIndex = 4;
            this.label3.Text = "Actual Rental Days:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label4.Location = new System.Drawing.Point(18, 52);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(75, 22);
            this.label4.TabIndex = 6;
            this.label4.Text = "Mileage:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label6.Location = new System.Drawing.Point(18, 97);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(163, 22);
            this.label6.TabIndex = 10;
            this.label6.Text = "Additional Charges:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label5.Location = new System.Drawing.Point(443, 52);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(164, 22);
            this.label5.TabIndex = 8;
            this.label5.Text = "Consumed Mileage:";
            // 
            // lblConsumedMileage
            // 
            this.lblConsumedMileage.AutoSize = true;
            this.lblConsumedMileage.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblConsumedMileage.Location = new System.Drawing.Point(605, 55);
            this.lblConsumedMileage.Name = "lblConsumedMileage";
            this.lblConsumedMileage.Size = new System.Drawing.Size(45, 19);
            this.lblConsumedMileage.TabIndex = 9;
            this.lblConsumedMileage.Text = "[???]";
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.lblReturnID);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(172, 106);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(829, 64);
            this.panel1.TabIndex = 16;
            // 
            // lblReturnID
            // 
            this.lblReturnID.AutoSize = true;
            this.lblReturnID.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblReturnID.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(9)))));
            this.lblReturnID.Location = new System.Drawing.Point(113, 20);
            this.lblReturnID.Name = "lblReturnID";
            this.lblReturnID.Size = new System.Drawing.Size(45, 19);
            this.lblReturnID.TabIndex = 1;
            this.lblReturnID.Text = "[???]";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 13F);
            this.label1.Location = new System.Drawing.Point(14, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Return ID:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label9.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label9.Location = new System.Drawing.Point(466, 3);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(274, 48);
            this.label9.TabIndex = 1;
            this.label9.Text = "Vehicle Return";
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 14F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(1014, 642);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(181, 34);
            this.btnClose.TabIndex = 18;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // frmVehicleReturn
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(1207, 682);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.tcVehicleReturn);
            this.MaximizeBox = false;
            this.Name = "frmVehicleReturn";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Vehicle Return";
            this.Activated += new System.EventHandler(this.frmVehicleReturn_Activated);
            this.Load += new System.EventHandler(this.frmVehicleReturn_Load);
            this.tcVehicleReturn.ResumeLayout(false);
            this.tpVehicleInfo.ResumeLayout(false);
            this.tpRentalBookingInfo.ResumeLayout(false);
            this.tpVehicleReturnInfo.ResumeLayout(false);
            this.tpVehicleReturnInfo.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudInitialRentalDays)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TabControl tcVehicleReturn;
        private System.Windows.Forms.TabPage tpVehicleInfo;
        private System.Windows.Forms.TabPage tpVehicleReturnInfo;
        private Vehicle.Controls.ctrlVehicleCardWithFilter ctrlVehicleCardWithFilter1;
        private System.Windows.Forms.TabPage tpRentalBookingInfo;
        private RentalBooking.Controls.ctrlRentalBookingCard ctrlRentalBookingCard1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lblReturnID;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.DateTimePicker dtpActualReturnDate;
        private System.Windows.Forms.Label lblConsumedMileage;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtMileage;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtFinalCheckNotes;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label lblActualTotalDueAmount;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btnNextToRentalBookingInfo;
        private System.Windows.Forms.Button btnNextToVehicleReturnInfo;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.TextBox txtAdditionalCharges;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.NumericUpDown nudInitialRentalDays;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label lblTotalRefundedAmount;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label lblTotalRemaining;
        private System.Windows.Forms.LinkLabel llShowVehicleReturnInfo;
    }
}