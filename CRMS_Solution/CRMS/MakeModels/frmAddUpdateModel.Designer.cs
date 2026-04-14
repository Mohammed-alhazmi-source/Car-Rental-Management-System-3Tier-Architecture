namespace CRMS.MakeModels
{
    partial class frmAddUpdateModel
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
            this.lblTitle = new System.Windows.Forms.Label();
            this.tcModel = new System.Windows.Forms.TabControl();
            this.tpMakeInfo = new System.Windows.Forms.TabPage();
            this.btnNextTab = new System.Windows.Forms.Button();
            this.ctrlMakeCardWithFilter1 = new CRMS.Make.Controls.ctrlMakeCardWithFilter();
            this.tpModelInfo = new System.Windows.Forms.TabPage();
            this.label2 = new System.Windows.Forms.Label();
            this.txtModelName = new System.Windows.Forms.TextBox();
            this.lblModelID = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.tcModel.SuspendLayout();
            this.tpMakeInfo.SuspendLayout();
            this.tpModelInfo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // lblTitle
            // 
            this.lblTitle.Font = new System.Drawing.Font("Tahoma", 25F);
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.lblTitle.Location = new System.Drawing.Point(279, 6);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(306, 53);
            this.lblTitle.TabIndex = 0;
            this.lblTitle.Text = "Title";
            this.lblTitle.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // tcModel
            // 
            this.tcModel.Controls.Add(this.tpMakeInfo);
            this.tcModel.Controls.Add(this.tpModelInfo);
            this.tcModel.Font = new System.Drawing.Font("Tahoma", 13F);
            this.tcModel.Location = new System.Drawing.Point(12, 55);
            this.tcModel.Name = "tcModel";
            this.tcModel.SelectedIndex = 0;
            this.tcModel.Size = new System.Drawing.Size(841, 383);
            this.tcModel.TabIndex = 1;
            // 
            // tpMakeInfo
            // 
            this.tpMakeInfo.BackColor = System.Drawing.Color.White;
            this.tpMakeInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpMakeInfo.Controls.Add(this.btnNextTab);
            this.tpMakeInfo.Controls.Add(this.ctrlMakeCardWithFilter1);
            this.tpMakeInfo.Location = new System.Drawing.Point(4, 30);
            this.tpMakeInfo.Name = "tpMakeInfo";
            this.tpMakeInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpMakeInfo.Size = new System.Drawing.Size(833, 349);
            this.tpMakeInfo.TabIndex = 0;
            this.tpMakeInfo.Text = "Make Info";
            // 
            // btnNextTab
            // 
            this.btnNextTab.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNextTab.Image = global::CRMS.Properties.Resources.Next_32;
            this.btnNextTab.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnNextTab.Location = new System.Drawing.Point(630, 291);
            this.btnNextTab.Name = "btnNextTab";
            this.btnNextTab.Size = new System.Drawing.Size(160, 39);
            this.btnNextTab.TabIndex = 1;
            this.btnNextTab.Text = "Next";
            this.btnNextTab.UseVisualStyleBackColor = true;
            this.btnNextTab.Click += new System.EventHandler(this.btnNextTab_Click);
            // 
            // ctrlMakeCardWithFilter1
            // 
            this.ctrlMakeCardWithFilter1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCardWithFilter1.FilterEnabled = true;
            this.ctrlMakeCardWithFilter1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ctrlMakeCardWithFilter1.Location = new System.Drawing.Point(26, 38);
            this.ctrlMakeCardWithFilter1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.ctrlMakeCardWithFilter1.Name = "ctrlMakeCardWithFilter1";
            this.ctrlMakeCardWithFilter1.Size = new System.Drawing.Size(778, 271);
            this.ctrlMakeCardWithFilter1.TabIndex = 0;
            this.ctrlMakeCardWithFilter1.OnMakeSelected += new System.EventHandler<CRMS.Make.Controls.ctrlMakeCardWithFilter.MakeSelectedEventArgs>(this.ctrlMakeCardWithFilter1_OnMakeSelected);
            this.ctrlMakeCardWithFilter1.OnMakeChanged += new System.Action<int>(this.ctrlMakeCardWithFilter1_OnMakeChanged);
            // 
            // tpModelInfo
            // 
            this.tpModelInfo.BackColor = System.Drawing.Color.White;
            this.tpModelInfo.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.tpModelInfo.Controls.Add(this.label2);
            this.tpModelInfo.Controls.Add(this.txtModelName);
            this.tpModelInfo.Controls.Add(this.lblModelID);
            this.tpModelInfo.Controls.Add(this.pictureBox1);
            this.tpModelInfo.Controls.Add(this.label1);
            this.tpModelInfo.Location = new System.Drawing.Point(4, 30);
            this.tpModelInfo.Name = "tpModelInfo";
            this.tpModelInfo.Padding = new System.Windows.Forms.Padding(3);
            this.tpModelInfo.Size = new System.Drawing.Size(833, 349);
            this.tpModelInfo.TabIndex = 1;
            this.tpModelInfo.Text = "Model Info";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(206, 184);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(114, 22);
            this.label2.TabIndex = 4;
            this.label2.Text = "Model Name:";
            // 
            // txtModelName
            // 
            this.txtModelName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtModelName.Location = new System.Drawing.Point(341, 182);
            this.txtModelName.MaxLength = 40;
            this.txtModelName.Multiline = true;
            this.txtModelName.Name = "txtModelName";
            this.txtModelName.Size = new System.Drawing.Size(283, 30);
            this.txtModelName.TabIndex = 0;
            this.txtModelName.Validating += new System.ComponentModel.CancelEventHandler(this.txtModelName_Validating);
            // 
            // lblModelID
            // 
            this.lblModelID.AutoSize = true;
            this.lblModelID.Location = new System.Drawing.Point(337, 138);
            this.lblModelID.Name = "lblModelID";
            this.lblModelID.Size = new System.Drawing.Size(51, 22);
            this.lblModelID.TabIndex = 2;
            this.lblModelID.Text = "[???]";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::CRMS.Properties.Resources.Number_32;
            this.pictureBox1.Location = new System.Drawing.Point(298, 135);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(33, 29);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(206, 138);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(88, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Model ID:";
            // 
            // btnSave
            // 
            this.btnSave.Enabled = false;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnSave.Image = global::CRMS.Properties.Resources.Save_32;
            this.btnSave.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSave.Location = new System.Drawing.Point(689, 440);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(160, 39);
            this.btnSave.TabIndex = 2;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnClose
            // 
            this.btnClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Tahoma", 13F);
            this.btnClose.Image = global::CRMS.Properties.Resources.Close_32;
            this.btnClose.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClose.Location = new System.Drawing.Point(523, 440);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(160, 39);
            this.btnClose.TabIndex = 3;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // frmAddUpdateModel
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.CancelButton = this.btnClose;
            this.ClientSize = new System.Drawing.Size(865, 494);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.lblTitle);
            this.Controls.Add(this.tcModel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "frmAddUpdateModel";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Add / Update Model";
            this.Activated += new System.EventHandler(this.frmAddUpdateModel_Activated);
            this.Load += new System.EventHandler(this.frmAddUpdateModel_Load);
            this.tcModel.ResumeLayout(false);
            this.tpMakeInfo.ResumeLayout(false);
            this.tpModelInfo.ResumeLayout(false);
            this.tpModelInfo.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.TabControl tcModel;
        private System.Windows.Forms.TabPage tpMakeInfo;
        private System.Windows.Forms.TabPage tpModelInfo;
        private Make.Controls.ctrlMakeCardWithFilter ctrlMakeCardWithFilter1;
        private System.Windows.Forms.Button btnNextTab;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Label lblModelID;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtModelName;
        private System.Windows.Forms.ErrorProvider errorProvider1;
    }
}