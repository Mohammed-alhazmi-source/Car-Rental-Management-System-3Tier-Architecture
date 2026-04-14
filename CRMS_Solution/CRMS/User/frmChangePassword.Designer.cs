namespace CRMS.User
{
    partial class frmChangePassword
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
            this.ctrlUserCard1 = new CRMS.User.Controls.ctrlUserCard();
            this.ckbShowHideConfirmPassword = new System.Windows.Forms.CheckBox();
            this.ckbShowHideNewPassword = new System.Windows.Forms.CheckBox();
            this.ckbShowHideCurrentPassword = new System.Windows.Forms.CheckBox();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.txtConfirmPassword = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtNewPassword = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtCurrentPassword = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // ctrlUserCard1
            // 
            this.ctrlUserCard1.BackColor = System.Drawing.Color.White;
            this.ctrlUserCard1.Font = new System.Drawing.Font("Tahoma", 7F, System.Drawing.FontStyle.Bold);
            this.ctrlUserCard1.Location = new System.Drawing.Point(-9, 32);
            this.ctrlUserCard1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.ctrlUserCard1.Name = "ctrlUserCard1";
            this.ctrlUserCard1.Size = new System.Drawing.Size(992, 376);
            this.ctrlUserCard1.TabIndex = 0;
            // 
            // ckbShowHideConfirmPassword
            // 
            this.ckbShowHideConfirmPassword.AutoSize = true;
            this.ckbShowHideConfirmPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.ckbShowHideConfirmPassword.Location = new System.Drawing.Point(625, 508);
            this.ckbShowHideConfirmPassword.Name = "ckbShowHideConfirmPassword";
            this.ckbShowHideConfirmPassword.Size = new System.Drawing.Size(67, 23);
            this.ckbShowHideConfirmPassword.TabIndex = 21;
            this.ckbShowHideConfirmPassword.Text = "Show";
            this.ckbShowHideConfirmPassword.UseVisualStyleBackColor = true;
            this.ckbShowHideConfirmPassword.CheckedChanged += new System.EventHandler(this.ckbShowHideConfirmPassword_CheckedChanged);
            // 
            // ckbShowHideNewPassword
            // 
            this.ckbShowHideNewPassword.AutoSize = true;
            this.ckbShowHideNewPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.ckbShowHideNewPassword.Location = new System.Drawing.Point(625, 472);
            this.ckbShowHideNewPassword.Name = "ckbShowHideNewPassword";
            this.ckbShowHideNewPassword.Size = new System.Drawing.Size(67, 23);
            this.ckbShowHideNewPassword.TabIndex = 20;
            this.ckbShowHideNewPassword.Text = "Show";
            this.ckbShowHideNewPassword.UseVisualStyleBackColor = true;
            this.ckbShowHideNewPassword.CheckedChanged += new System.EventHandler(this.ckbShowHideNewPassword_CheckedChanged);
            // 
            // ckbShowHideCurrentPassword
            // 
            this.ckbShowHideCurrentPassword.AutoSize = true;
            this.ckbShowHideCurrentPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.ckbShowHideCurrentPassword.Location = new System.Drawing.Point(625, 435);
            this.ckbShowHideCurrentPassword.Name = "ckbShowHideCurrentPassword";
            this.ckbShowHideCurrentPassword.Size = new System.Drawing.Size(67, 23);
            this.ckbShowHideCurrentPassword.TabIndex = 19;
            this.ckbShowHideCurrentPassword.Text = "Show";
            this.ckbShowHideCurrentPassword.UseVisualStyleBackColor = true;
            this.ckbShowHideCurrentPassword.CheckedChanged += new System.EventHandler(this.ckbShowHideCurrentPassword_CheckedChanged);
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(607, 557);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(147, 40);
            this.btnClose.TabIndex = 16;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnSave
            // 
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnSave.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSave.Location = new System.Drawing.Point(760, 557);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(147, 40);
            this.btnSave.TabIndex = 14;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 12F);
            this.label4.Location = new System.Drawing.Point(274, 506);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(144, 19);
            this.label4.TabIndex = 18;
            this.label4.Text = "Confirm Password:";
            // 
            // txtConfirmPassword
            // 
            this.txtConfirmPassword.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtConfirmPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.txtConfirmPassword.Location = new System.Drawing.Point(424, 504);
            this.txtConfirmPassword.Multiline = true;
            this.txtConfirmPassword.Name = "txtConfirmPassword";
            this.txtConfirmPassword.Size = new System.Drawing.Size(195, 30);
            this.txtConfirmPassword.TabIndex = 13;
            this.txtConfirmPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtConfirmPassword_Validating);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F);
            this.label3.Location = new System.Drawing.Point(300, 470);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(118, 19);
            this.label3.TabIndex = 17;
            this.label3.Text = "New Password:";
            // 
            // txtNewPassword
            // 
            this.txtNewPassword.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtNewPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.txtNewPassword.Location = new System.Drawing.Point(424, 468);
            this.txtNewPassword.Multiline = true;
            this.txtNewPassword.Name = "txtNewPassword";
            this.txtNewPassword.Size = new System.Drawing.Size(195, 30);
            this.txtNewPassword.TabIndex = 12;
            this.txtNewPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtNewPassword_Validating);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 12F);
            this.label2.Location = new System.Drawing.Point(281, 434);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(137, 19);
            this.label2.TabIndex = 15;
            this.label2.Text = "current Password:";
            // 
            // txtCurrentPassword
            // 
            this.txtCurrentPassword.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtCurrentPassword.Font = new System.Drawing.Font("Tahoma", 12F);
            this.txtCurrentPassword.Location = new System.Drawing.Point(424, 432);
            this.txtCurrentPassword.Multiline = true;
            this.txtCurrentPassword.Name = "txtCurrentPassword";
            this.txtCurrentPassword.Size = new System.Drawing.Size(195, 30);
            this.txtCurrentPassword.TabIndex = 11;
            this.txtCurrentPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtCurrentPassword_Validating);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 25F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(342, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(283, 41);
            this.label1.TabIndex = 22;
            this.label1.Text = "Change Password";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // frmChangePassword
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(966, 609);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ckbShowHideConfirmPassword);
            this.Controls.Add(this.ckbShowHideNewPassword);
            this.Controls.Add(this.ckbShowHideCurrentPassword);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtConfirmPassword);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtNewPassword);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCurrentPassword);
            this.Controls.Add(this.ctrlUserCard1);
            this.MaximizeBox = false;
            this.Name = "frmChangePassword";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Change Password";
            this.Activated += new System.EventHandler(this.frmChangePassword_Activated);
            this.Load += new System.EventHandler(this.frmChangePassword_Load);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Controls.ctrlUserCard ctrlUserCard1;
        private System.Windows.Forms.CheckBox ckbShowHideConfirmPassword;
        private System.Windows.Forms.CheckBox ckbShowHideNewPassword;
        private System.Windows.Forms.CheckBox ckbShowHideCurrentPassword;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtConfirmPassword;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtNewPassword;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtCurrentPassword;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ErrorProvider errorProvider1;
    }
}