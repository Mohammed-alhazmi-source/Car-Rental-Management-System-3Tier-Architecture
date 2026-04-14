namespace CRMS.Vehicle
{
    partial class frmFindVehicle
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
            this.ctrlVehicleCardWithFilter1 = new CRMS.Vehicle.Controls.ctrlVehicleCardWithFilter();
            this.SuspendLayout();
            // 
            // ctrlVehicleCardWithFilter1
            // 
            this.ctrlVehicleCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlVehicleCardWithFilter1.FilterEnabled = true;
            this.ctrlVehicleCardWithFilter1.Location = new System.Drawing.Point(1, -6);
            this.ctrlVehicleCardWithFilter1.Name = "ctrlVehicleCardWithFilter1";
            this.ctrlVehicleCardWithFilter1.Size = new System.Drawing.Size(1182, 454);
            this.ctrlVehicleCardWithFilter1.TabIndex = 0;
            // 
            // frmFindVehicle
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1195, 450);
            this.Controls.Add(this.ctrlVehicleCardWithFilter1);
            this.MaximizeBox = false;
            this.Name = "frmFindVehicle";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Find Vehicle";
            this.ResumeLayout(false);

        }

        #endregion

        private Controls.ctrlVehicleCardWithFilter ctrlVehicleCardWithFilter1;
    }
}