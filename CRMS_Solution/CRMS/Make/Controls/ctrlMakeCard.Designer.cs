namespace CRMS.Make.Controls
{
    partial class ctrlMakeCard
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
            this.llEditMakeInfo = new System.Windows.Forms.LinkLabel();
            this.lblMakeName = new System.Windows.Forms.Label();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.label3 = new System.Windows.Forms.Label();
            this.lblMakeID = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.llEditMakeInfo);
            this.groupBox1.Controls.Add(this.lblMakeName);
            this.groupBox1.Controls.Add(this.pictureBox2);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.lblMakeID);
            this.groupBox1.Controls.Add(this.pictureBox1);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 13F);
            this.groupBox1.ForeColor = System.Drawing.Color.DimGray;
            this.groupBox1.Location = new System.Drawing.Point(13, 54);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(751, 127);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Make Information";
            // 
            // llEditMakeInfo
            // 
            this.llEditMakeInfo.AutoSize = true;
            this.llEditMakeInfo.Enabled = false;
            this.llEditMakeInfo.Location = new System.Drawing.Point(604, 21);
            this.llEditMakeInfo.Name = "llEditMakeInfo";
            this.llEditMakeInfo.Size = new System.Drawing.Size(131, 22);
            this.llEditMakeInfo.TabIndex = 6;
            this.llEditMakeInfo.TabStop = true;
            this.llEditMakeInfo.Text = "Edit Make Info.";
            this.llEditMakeInfo.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.llEditMakeInfo_LinkClicked);
            // 
            // lblMakeName
            // 
            this.lblMakeName.AutoSize = true;
            this.lblMakeName.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblMakeName.ForeColor = System.Drawing.Color.Black;
            this.lblMakeName.Location = new System.Drawing.Point(522, 76);
            this.lblMakeName.Name = "lblMakeName";
            this.lblMakeName.Size = new System.Drawing.Size(45, 19);
            this.lblMakeName.TabIndex = 5;
            this.lblMakeName.Text = "[???]";
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = global::CRMS.Properties.Resources.Number_32;
            this.pictureBox2.Location = new System.Drawing.Point(478, 73);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(40, 25);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox2.TabIndex = 4;
            this.pictureBox2.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.ForeColor = System.Drawing.Color.Black;
            this.label3.Location = new System.Drawing.Point(373, 73);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(108, 22);
            this.label3.TabIndex = 3;
            this.label3.Text = "Make Name:";
            // 
            // lblMakeID
            // 
            this.lblMakeID.AutoSize = true;
            this.lblMakeID.Font = new System.Drawing.Font("Tahoma", 12F);
            this.lblMakeID.ForeColor = System.Drawing.Color.Black;
            this.lblMakeID.Location = new System.Drawing.Point(236, 76);
            this.lblMakeID.Name = "lblMakeID";
            this.lblMakeID.Size = new System.Drawing.Size(45, 19);
            this.lblMakeID.TabIndex = 2;
            this.lblMakeID.Text = "[???]";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::CRMS.Properties.Resources.Number_32;
            this.pictureBox1.Location = new System.Drawing.Point(191, 73);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(40, 25);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(112, 73);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(82, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Make ID:";
            // 
            // ctrlMakeCard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.groupBox1);
            this.Name = "ctrlMakeCard";
            this.Size = new System.Drawing.Size(777, 235);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label lblMakeID;
        private System.Windows.Forms.Label lblMakeName;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.LinkLabel llEditMakeInfo;
    }
}
