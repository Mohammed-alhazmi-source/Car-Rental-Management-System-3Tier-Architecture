namespace CRMS.Make.Controls
{
    partial class ctrlMakeCardWithFilter
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
            this.cbFilterBy = new System.Windows.Forms.ComboBox();
            this.txtValueFilter = new System.Windows.Forms.TextBox();
            this.btnAddNewMake = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.ctrlMakeCard1 = new CRMS.Make.Controls.ctrlMakeCard();
            this.gbFilters = new System.Windows.Forms.GroupBox();
            this.btnSearch = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.gbFilters.SuspendLayout();
            this.SuspendLayout();
            // 
            // cbFilterBy
            // 
            this.cbFilterBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFilterBy.FormattingEnabled = true;
            this.cbFilterBy.Items.AddRange(new object[] {
            "Make Name",
            "Make ID"});
            this.cbFilterBy.Location = new System.Drawing.Point(81, 37);
            this.cbFilterBy.Name = "cbFilterBy";
            this.cbFilterBy.Size = new System.Drawing.Size(196, 29);
            this.cbFilterBy.TabIndex = 7;
            this.cbFilterBy.SelectedIndexChanged += new System.EventHandler(this.cbFilterBy_SelectedIndexChanged);
            // 
            // txtValueFilter
            // 
            this.txtValueFilter.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtValueFilter.Location = new System.Drawing.Point(287, 37);
            this.txtValueFilter.Name = "txtValueFilter";
            this.txtValueFilter.Size = new System.Drawing.Size(269, 28);
            this.txtValueFilter.TabIndex = 6;
            this.txtValueFilter.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtValueFilter_KeyPress);
            this.txtValueFilter.Validating += new System.ComponentModel.CancelEventHandler(this.txtValueFilter_Validating);
            // 
            // btnAddNewMake
            // 
            this.btnAddNewMake.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddNewMake.Image = global::CRMS.Properties.Resources.add_32;
            this.btnAddNewMake.Location = new System.Drawing.Point(665, 24);
            this.btnAddNewMake.Name = "btnAddNewMake";
            this.btnAddNewMake.Size = new System.Drawing.Size(68, 52);
            this.btnAddNewMake.TabIndex = 4;
            this.btnAddNewMake.UseVisualStyleBackColor = true;
            this.btnAddNewMake.Click += new System.EventHandler(this.btnAddNewMake_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 12F);
            this.label1.ForeColor = System.Drawing.Color.Black;
            this.label1.Location = new System.Drawing.Point(6, 42);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(72, 19);
            this.label1.TabIndex = 0;
            this.label1.Text = "Filter By:";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // ctrlMakeCard1
            // 
            this.ctrlMakeCard1.BackColor = System.Drawing.Color.White;
            this.ctrlMakeCard1.Location = new System.Drawing.Point(1, 65);
            this.ctrlMakeCard1.Name = "ctrlMakeCard1";
            this.ctrlMakeCard1.Size = new System.Drawing.Size(777, 189);
            this.ctrlMakeCard1.TabIndex = 4;
            this.ctrlMakeCard1.OnMakeChanged += new System.Action<int>(this.ctrlMakeCard1_OnMakeChanged);
            // 
            // gbFilters
            // 
            this.gbFilters.Controls.Add(this.btnSearch);
            this.gbFilters.Controls.Add(this.txtValueFilter);
            this.gbFilters.Controls.Add(this.label1);
            this.gbFilters.Controls.Add(this.cbFilterBy);
            this.gbFilters.Controls.Add(this.btnAddNewMake);
            this.gbFilters.Font = new System.Drawing.Font("Tahoma", 13F);
            this.gbFilters.ForeColor = System.Drawing.Color.DimGray;
            this.gbFilters.Location = new System.Drawing.Point(14, 19);
            this.gbFilters.Name = "gbFilters";
            this.gbFilters.Size = new System.Drawing.Size(750, 100);
            this.gbFilters.TabIndex = 9;
            this.gbFilters.TabStop = false;
            this.gbFilters.Text = "Filter";
            // 
            // btnSearch
            // 
            this.btnSearch.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSearch.Image = global::CRMS.Properties.Resources.search_30px;
            this.btnSearch.Location = new System.Drawing.Point(584, 24);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(75, 52);
            this.btnSearch.TabIndex = 8;
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // ctrlMakeCardWithFilter
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.Controls.Add(this.gbFilters);
            this.Controls.Add(this.ctrlMakeCard1);
            this.Name = "ctrlMakeCardWithFilter";
            this.Size = new System.Drawing.Size(778, 253);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.gbFilters.ResumeLayout(false);
            this.gbFilters.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btnAddNewMake;
        private System.Windows.Forms.Label label1;
        private ctrlMakeCard ctrlMakeCard1;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.TextBox txtValueFilter;
        private System.Windows.Forms.ComboBox cbFilterBy;
        private System.Windows.Forms.GroupBox gbFilters;
        private System.Windows.Forms.Button btnSearch;
    }
}
