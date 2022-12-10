
namespace SeminarskiRSII.WinUI.Rezervacija
{
    partial class frmRezervacijaPrikaz
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
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwRezervacije = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Gost = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Soba = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DatumRezervacije = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ZavrsetakRezervacije = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwRezervacije)).BeginInit();
            this.SuspendLayout();
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnPrikazi.Location = new System.Drawing.Point(710, 108);
            this.btnPrikazi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(140, 75);
            this.btnPrikazi.TabIndex = 15;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtPretraga.Location = new System.Drawing.Point(42, 125);
            this.txtPretraga.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(609, 30);
            this.txtPretraga.TabIndex = 14;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(35, 42);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(191, 29);
            this.label1.TabIndex = 13;
            this.label1.Text = "Pretraga po sobi";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwRezervacije);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(37, 212);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(818, 538);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista rezervacija";
            // 
            // dgwRezervacije
            // 
            this.dgwRezervacije.AllowUserToAddRows = false;
            this.dgwRezervacije.AllowUserToDeleteRows = false;
            this.dgwRezervacije.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwRezervacije.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Gost,
            this.Soba,
            this.DatumRezervacije,
            this.ZavrsetakRezervacije});
            this.dgwRezervacije.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwRezervacije.Location = new System.Drawing.Point(5, 34);
            this.dgwRezervacije.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwRezervacije.Name = "dgwRezervacije";
            this.dgwRezervacije.ReadOnly = true;
            this.dgwRezervacije.RowHeadersWidth = 62;
            this.dgwRezervacije.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwRezervacije.Size = new System.Drawing.Size(808, 498);
            this.dgwRezervacije.TabIndex = 0;
            this.dgwRezervacije.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwRezervacije_MouseDoubleClick);
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
            // Gost
            // 
            this.Gost.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Gost.DataPropertyName = "Gost";
            this.Gost.HeaderText = "Gost";
            this.Gost.MinimumWidth = 8;
            this.Gost.Name = "Gost";
            this.Gost.ReadOnly = true;
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
            // DatumRezervacije
            // 
            this.DatumRezervacije.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DatumRezervacije.DataPropertyName = "DatumRezervacije";
            this.DatumRezervacije.HeaderText = "Datum Rezervacije";
            this.DatumRezervacije.MinimumWidth = 8;
            this.DatumRezervacije.Name = "DatumRezervacije";
            this.DatumRezervacije.ReadOnly = true;
            // 
            // ZavrsetakRezervacije
            // 
            this.ZavrsetakRezervacije.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.ZavrsetakRezervacije.DataPropertyName = "ZavrsetakRezervacije";
            this.ZavrsetakRezervacije.HeaderText = "Zavrsetak Rezervacije";
            this.ZavrsetakRezervacije.MinimumWidth = 8;
            this.ZavrsetakRezervacije.Name = "ZavrsetakRezervacije";
            this.ZavrsetakRezervacije.ReadOnly = true;
            // 
            // frmRezervacijaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(873, 765);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmRezervacijaPrikaz";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmRezervacijaPrikaz";
            this.Load += new System.EventHandler(this.frmRezervacijaPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwRezervacije)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwRezervacije;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Gost;
        private System.Windows.Forms.DataGridViewTextBoxColumn Soba;
        private System.Windows.Forms.DataGridViewTextBoxColumn DatumRezervacije;
        private System.Windows.Forms.DataGridViewTextBoxColumn ZavrsetakRezervacije;
    }
}