namespace CRMS.RentalTransaction
{
    partial class frmShowRentalTransactionInfo
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
            this.ctrlRentalTransactionCard1 = new CRMS.RentalTransaction.Controls.ctrlRentalTransactionCard();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(323, 5);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(567, 48);
            this.label1.TabIndex = 1;
            this.label1.Text = "Rental Transaction Information";
            // 
            // ctrlRentalTransactionCard1
            // 
            this.ctrlRentalTransactionCard1.BackColor = System.Drawing.Color.White;
            this.ctrlRentalTransactionCard1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlRentalTransactionCard1.Location = new System.Drawing.Point(21, 51);
            this.ctrlRentalTransactionCard1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.ctrlRentalTransactionCard1.Name = "ctrlRentalTransactionCard1";
            this.ctrlRentalTransactionCard1.Size = new System.Drawing.Size(1170, 888);
            this.ctrlRentalTransactionCard1.TabIndex = 0;
            // 
            // frmShowRentalTransactionInfo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(5F, 11F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1229, 521);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ctrlRentalTransactionCard1);
            this.Font = new System.Drawing.Font("Tahoma", 7F);
            this.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.MaximizeBox = false;
            this.Name = "frmShowRentalTransactionInfo";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Show Rental Transaction Info";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Controls.ctrlRentalTransactionCard ctrlRentalTransactionCard1;
        private System.Windows.Forms.Label label1;
    }
}