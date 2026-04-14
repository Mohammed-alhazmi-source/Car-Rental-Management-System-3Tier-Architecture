namespace CRMS.Vehicle.Controls
{
    partial class ctrlVehicleCardWithFilter
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
            this.components = new System.ComponentModel.Container();
            this.gbFilters = new System.Windows.Forms.GroupBox();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnFind = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.ctrlVehicleCard1 = new CRMS.Vehicle.Controls.ctrlVehicleCard();
            this.txtMakeName = new System.Windows.Forms.TextBox();
            this.txtModelName = new System.Windows.Forms.TextBox();
            this.gbFilters.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.SuspendLayout();
            // 
            // gbFilters
            // 
            this.gbFilters.Controls.Add(this.txtModelName);
            this.gbFilters.Controls.Add(this.txtMakeName);
            this.gbFilters.Controls.Add(this.btnAdd);
            this.gbFilters.Controls.Add(this.btnFind);
            this.gbFilters.Controls.Add(this.label2);
            this.gbFilters.Controls.Add(this.label1);
            this.gbFilters.Font = new System.Drawing.Font("Tahoma", 13F);
            this.gbFilters.ForeColor = System.Drawing.Color.DimGray;
            this.gbFilters.Location = new System.Drawing.Point(39, 15);
            this.gbFilters.Name = "gbFilters";
            this.gbFilters.Size = new System.Drawing.Size(1105, 113);
            this.gbFilters.TabIndex = 2;
            this.gbFilters.TabStop = false;
            this.gbFilters.Text = "Filter";
            // 
            // btnAdd
            // 
            this.btnAdd.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAdd.Image = global::CRMS.Properties.Resources.add_32;
            this.btnAdd.Location = new System.Drawing.Point(968, 27);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(75, 61);
            this.btnAdd.TabIndex = 6;
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnFind
            // 
            this.btnFind.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnFind.Image = global::CRMS.Properties.Resources.search_30px;
            this.btnFind.Location = new System.Drawing.Point(887, 27);
            this.btnFind.Name = "btnFind";
            this.btnFind.Size = new System.Drawing.Size(75, 61);
            this.btnFind.TabIndex = 5;
            this.btnFind.UseVisualStyleBackColor = true;
            this.btnFind.Click += new System.EventHandler(this.btnFind_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.ForeColor = System.Drawing.Color.Black;
            this.label2.Location = new System.Drawing.Point(420, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 22);
            this.label2.TabIndex = 3;
            this.label2.Text = "Model:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(21, 50);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(57, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Make:";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // ctrlVehicleCard1
            // 
            this.ctrlVehicleCard1.BackColor = System.Drawing.Color.White;
            this.ctrlVehicleCard1.Location = new System.Drawing.Point(25, 111);
            this.ctrlVehicleCard1.Name = "ctrlVehicleCard1";
            this.ctrlVehicleCard1.Size = new System.Drawing.Size(1133, 340);
            this.ctrlVehicleCard1.TabIndex = 3;
            // 
            // txtMakeName
            // 
            this.txtMakeName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtMakeName.Location = new System.Drawing.Point(85, 45);
            this.txtMakeName.Name = "txtMakeName";
            this.txtMakeName.Size = new System.Drawing.Size(324, 28);
            this.txtMakeName.TabIndex = 9;
            this.txtMakeName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtMakeName_KeyPress);
            this.txtMakeName.Validating += new System.ComponentModel.CancelEventHandler(this.txtMakeName_Validating);
            // 
            // txtModelName
            // 
            this.txtModelName.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtModelName.Location = new System.Drawing.Point(485, 45);
            this.txtModelName.Name = "txtModelName";
            this.txtModelName.Size = new System.Drawing.Size(324, 28);
            this.txtModelName.TabIndex = 10;
            this.txtModelName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtModelName_KeyPress);
            this.txtModelName.Validating += new System.ComponentModel.CancelEventHandler(this.txtModelName_Validating);
            // 
            // ctrlVehicleCardWithFilter
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.gbFilters);
            this.Controls.Add(this.ctrlVehicleCard1);
            this.Name = "ctrlVehicleCardWithFilter";
            this.Size = new System.Drawing.Size(1182, 489);
            this.gbFilters.ResumeLayout(false);
            this.gbFilters.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbFilters;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnFind;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private ctrlVehicleCard ctrlVehicleCard1;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox txtMakeName;
        private System.Windows.Forms.TextBox txtModelName;
    }
}
