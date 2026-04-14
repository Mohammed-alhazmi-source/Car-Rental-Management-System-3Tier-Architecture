namespace CRMS.Make
{
    partial class frmFindMake
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
            this.label1 = new System.Windows.Forms.Label();
            this.btnClose = new System.Windows.Forms.Button();
            this.ctrlMakeCardWithFilter1 = new CRMS.Make.Controls.ctrlMakeCardWithFilter();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 25F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(314, 38);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(172, 41);
            this.label1.TabIndex = 0;
            this.label1.Text = "Find Make";
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(602, 362);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(166, 35);
            this.btnClose.TabIndex = 2;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // ctrlMakeCardWithFilter1
            // 
            this.ctrlMakeCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCardWithFilter1.FilterEnabled = true;
            this.ctrlMakeCardWithFilter1.Location = new System.Drawing.Point(5, 88);
            this.ctrlMakeCardWithFilter1.Name = "ctrlMakeCardWithFilter1";
            this.ctrlMakeCardWithFilter1.Size = new System.Drawing.Size(776, 271);
            this.ctrlMakeCardWithFilter1.TabIndex = 1;
            this.ctrlMakeCardWithFilter1.OnMakeSelected += new System.EventHandler<CRMS.Make.Controls.ctrlMakeCardWithFilter.MakeSelectedEventArgs>(this.ctrlMakeCardWithFilter1_OnMakeSelected);
            // 
            // frmFindMake
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(787, 408);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.ctrlMakeCardWithFilter1);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmFindMake";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Find Make";
            this.Activated += new System.EventHandler(this.frmFindMake_Activated);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.frmFindMake_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private Controls.ctrlMakeCardWithFilter ctrlMakeCardWithFilter1;
        private System.Windows.Forms.Button btnClose;
    }
}