namespace CRMS.FuelTypes.Controls
{
    partial class ctrlFuelTypeCard
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.llEditFuelTypeInfo = new System.Windows.Forms.LinkLabel();
            this.lblFuelType = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblFuelTypeID = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.llEditFuelTypeInfo);
            this.groupBox1.Controls.Add(this.lblFuelType);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.lblFuelTypeID);
            this.groupBox1.Controls.Add(this.pictureBox1);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 13F);
            this.groupBox1.ForeColor = System.Drawing.Color.DimGray;
            this.groupBox1.Location = new System.Drawing.Point(23, 22);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(797, 120);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Fuel Type Information";
            // 
            // llEditFuelTypeInfo
            // 
            this.llEditFuelTypeInfo.AutoSize = true;
            this.llEditFuelTypeInfo.Location = new System.Drawing.Point(606, 24);
            this.llEditFuelTypeInfo.Name = "llEditFuelTypeInfo";
            this.llEditFuelTypeInfo.Size = new System.Drawing.Size(167, 22);
            this.llEditFuelTypeInfo.TabIndex = 6;
            this.llEditFuelTypeInfo.TabStop = true;
            this.llEditFuelTypeInfo.Text = "Edit Fuel Type Info.";
            this.llEditFuelTypeInfo.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.llEditFuelTypeInfo_LinkClicked);
            // 
            // lblFuelType
            // 
            this.lblFuelType.AutoSize = true;
            this.lblFuelType.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblFuelType.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblFuelType.Location = new System.Drawing.Point(447, 70);
            this.lblFuelType.Name = "lblFuelType";
            this.lblFuelType.Size = new System.Drawing.Size(33, 19);
            this.lblFuelType.TabIndex = 5;
            this.lblFuelType.Text = "???";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(355, 67);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(93, 22);
            this.label3.TabIndex = 3;
            this.label3.Text = "Fuel Type:";
            // 
            // lblFuelTypeID
            // 
            this.lblFuelTypeID.AutoSize = true;
            this.lblFuelTypeID.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblFuelTypeID.ForeColor = System.Drawing.Color.Black;
            this.lblFuelTypeID.Location = new System.Drawing.Point(180, 70);
            this.lblFuelTypeID.Name = "lblFuelTypeID";
            this.lblFuelTypeID.Size = new System.Drawing.Size(33, 19);
            this.lblFuelTypeID.TabIndex = 2;
            this.lblFuelTypeID.Text = "???";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::CRMS.Properties.Resources.Number_32;
            this.pictureBox1.Location = new System.Drawing.Point(147, 61);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(27, 31);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(26, 67);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(118, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Fuel Type ID:";
            // 
            // ctrlFuelTypeCard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.groupBox1);
            this.Name = "ctrlFuelTypeCard";
            this.Size = new System.Drawing.Size(839, 165);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblFuelTypeID;
        private System.Windows.Forms.Label lblFuelType;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.LinkLabel llEditFuelTypeInfo;
    }
}
