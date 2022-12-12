
namespace SeminarskiRSII.WinUI.SobaOsoblje
{
    partial class frmSobaOsobljePrikaz
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
            this.dgwSobaOsoblje = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Soba = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Osoblje = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Obrisi = new System.Windows.Forms.DataGridViewButtonColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaOsoblje)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwSobaOsoblje);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(20, 42);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(868, 771);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Upsoslenici zaduzeni za sobu";
            // 
            // dgwSobaOsoblje
            // 
            this.dgwSobaOsoblje.AllowUserToAddRows = false;
            this.dgwSobaOsoblje.AllowUserToDeleteRows = false;
            this.dgwSobaOsoblje.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwSobaOsoblje.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Soba,
            this.Osoblje,
            this.Obrisi});
            this.dgwSobaOsoblje.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwSobaOsoblje.Location = new System.Drawing.Point(5, 34);
            this.dgwSobaOsoblje.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwSobaOsoblje.Name = "dgwSobaOsoblje";
            this.dgwSobaOsoblje.ReadOnly = true;
            this.dgwSobaOsoblje.RowHeadersWidth = 62;
            this.dgwSobaOsoblje.RowTemplate.Height = 45;
            this.dgwSobaOsoblje.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwSobaOsoblje.Size = new System.Drawing.Size(858, 731);
            this.dgwSobaOsoblje.TabIndex = 0;
            this.dgwSobaOsoblje.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwSobaOsoblje_MouseDoubleClick);
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
            // Osoblje
            // 
            this.Osoblje.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Osoblje.DataPropertyName = "Osoblje";
            this.Osoblje.HeaderText = "Osoblje";
            this.Osoblje.MinimumWidth = 8;
            this.Osoblje.Name = "Osoblje";
            this.Osoblje.ReadOnly = true;
            // 
            // Obrisi
            // 
            this.Obrisi.HeaderText = "Obrisi";
            this.Obrisi.MinimumWidth = 8;
            this.Obrisi.Name = "Obrisi";
            this.Obrisi.ReadOnly = true;
            this.Obrisi.Text = "Obrisi";
            this.Obrisi.UseColumnTextForButtonValue = true;
            this.Obrisi.Width = 150;
            // 
            // frmSobaOsobljePrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(900, 865);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmSobaOsobljePrikaz";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmSobaOsobljePrikaz";
            this.Load += new System.EventHandler(this.frmSobaOsobljePrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaOsoblje)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwSobaOsoblje;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn Soba;
        private DataGridViewTextBoxColumn Osoblje;
        private DataGridViewButtonColumn Obrisi;
    }
}