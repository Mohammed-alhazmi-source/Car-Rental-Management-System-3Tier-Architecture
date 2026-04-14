namespace CRMS.Make
{
    partial class frmShowMakeModelsHistory
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
            this.ctrlMakeModelsHistory1 = new CRMS.MakeModels.Controls.ctrlMakeModelsHistory();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 30F);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(9)))));
            this.label1.Location = new System.Drawing.Point(358, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(385, 48);
            this.label1.TabIndex = 1;
            this.label1.Text = "Make Models History";
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(859, 658);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(177, 35);
            this.btnClose.TabIndex = 2;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            // 
            // ctrlMakeModelsHistory1
            // 
            this.ctrlMakeModelsHistory1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeModelsHistory1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlMakeModelsHistory1.Location = new System.Drawing.Point(11, 71);
            this.ctrlMakeModelsHistory1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.ctrlMakeModelsHistory1.Name = "ctrlMakeModelsHistory1";
            this.ctrlMakeModelsHistory1.Size = new System.Drawing.Size(1045, 603);
            this.ctrlMakeModelsHistory1.TabIndex = 0;
            // 
            // frmShowMakeModelsHistory
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(1100, 705);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.ctrlMakeModelsHistory1);
            this.MaximizeBox = false;
            this.Name = "frmShowMakeModelsHistory";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Show Make Models History";
            this.Activated += new System.EventHandler(this.frmShowMakeModelsHistory_Activated);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MakeModels.Controls.ctrlMakeModelsHistory ctrlMakeModelsHistory1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnClose;
    }
}