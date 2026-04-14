namespace CRMS.VehicleReturn
{
    partial class frmShowVehicleReturnInfo
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
            this.ctrlVehicleReturnCard1 = new CRMS.VehicleReturn.Controls.ctrlVehicleReturnCard();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(9)))));
            this.label1.Location = new System.Drawing.Point(333, -3);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(494, 48);
            this.label1.TabIndex = 0;
            this.label1.Text = "Vehicle Return Information";
            // 
            // ctrlVehicleReturnCard1
            // 
            this.ctrlVehicleReturnCard1.AutoSize = true;
            this.ctrlVehicleReturnCard1.BackColor = System.Drawing.Color.White;
            this.ctrlVehicleReturnCard1.Font = new System.Drawing.Font("Segoe UI", 8F);
            this.ctrlVehicleReturnCard1.Location = new System.Drawing.Point(12, 30);
            this.ctrlVehicleReturnCard1.Name = "ctrlVehicleReturnCard1";
            this.ctrlVehicleReturnCard1.Size = new System.Drawing.Size(1137, 701);
            this.ctrlVehicleReturnCard1.TabIndex = 3;
            // 
            // frmShowVehicleReturnInfo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1161, 731);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ctrlVehicleReturnCard1);
            this.MaximizeBox = false;
            this.Name = "frmShowVehicleReturnInfo";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Show Vehicle Return Info";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private Controls.ctrlVehicleReturnCard ctrlVehicleReturnCard1;
    }
}