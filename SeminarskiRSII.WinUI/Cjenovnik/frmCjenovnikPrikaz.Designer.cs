
namespace SeminarskiRSII.WinUI.Cjenovnik
{
    partial class frmCjenovnikPrikaz
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwCjenovnik = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Soba = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BrojDana = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Cijena = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwCjenovnik)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwCjenovnik);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(20, 23);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(1095, 746);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista cijena";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // dgwCjenovnik
            // 
            this.dgwCjenovnik.AllowUserToAddRows = false;
            this.dgwCjenovnik.AllowUserToDeleteRows = false;
            this.dgwCjenovnik.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwCjenovnik.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Soba,
            this.BrojDana,
            this.Cijena});
            this.dgwCjenovnik.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwCjenovnik.Location = new System.Drawing.Point(5, 34);
            this.dgwCjenovnik.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwCjenovnik.Name = "dgwCjenovnik";
            this.dgwCjenovnik.ReadOnly = true;
            this.dgwCjenovnik.RowHeadersWidth = 62;
            this.dgwCjenovnik.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwCjenovnik.Size = new System.Drawing.Size(1085, 706);
            this.dgwCjenovnik.TabIndex = 0;
            this.dgwCjenovnik.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwCjenovnik_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.MinimumWidth = 8;
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            this.Id.Width = 150;
            // 
            // Soba
            // 
            this.Soba.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Soba.DataPropertyName = "Soba";
            this.Soba.HeaderText = "Soba";
            this.Soba.MinimumWidth = 8;
            this.Soba.Name = "Soba";
            this.Soba.ReadOnly = true;
            // 
            // BrojDana
            // 
            this.BrojDana.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.BrojDana.DataPropertyName = "BrojDana";
            this.BrojDana.HeaderText = "Broj Dana";
            this.BrojDana.MinimumWidth = 8;
            this.BrojDana.Name = "BrojDana";
            this.BrojDana.ReadOnly = true;
            // 
            // Cijena
            // 
            this.Cijena.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Cijena.DataPropertyName = "Cijena";
            this.Cijena.HeaderText = "Cijena";
            this.Cijena.MinimumWidth = 8;
            this.Cijena.Name = "Cijena";
            this.Cijena.ReadOnly = true;
            // 
            // frmCjenovnikPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1133, 783);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmCjenovnikPrikaz";
            this.Text = "frmCjenovnikPrikaz";
            this.Load += new System.EventHandler(this.frmCjenovnikPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwCjenovnik)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwCjenovnik;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Soba;
        private System.Windows.Forms.DataGridViewTextBoxColumn BrojDana;
        private System.Windows.Forms.DataGridViewTextBoxColumn Cijena;
    }
}