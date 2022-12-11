
namespace SeminarskiRSII.WinUI.Soba
{
    partial class frmSobaPrikaz
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
            this.dgwSoba = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BrojSprata = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BrojSobe = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.OpisSobe = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SobaStatus = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Slika = new System.Windows.Forms.DataGridViewImageColumn();
            this.Obrisi = new System.Windows.Forms.DataGridViewButtonColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwSoba)).BeginInit();
            this.SuspendLayout();
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnPrikazi.Location = new System.Drawing.Point(760, 73);
            this.btnPrikazi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(125, 62);
            this.btnPrikazi.TabIndex = 15;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtPretraga.Location = new System.Drawing.Point(35, 85);
            this.txtPretraga.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(697, 30);
            this.txtPretraga.TabIndex = 14;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(35, 17);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 29);
            this.label1.TabIndex = 13;
            this.label1.Text = "Pretraga";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwSoba);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(28, 146);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(880, 712);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista soba";
            // 
            // dgwSoba
            // 
            this.dgwSoba.AllowUserToAddRows = false;
            this.dgwSoba.AllowUserToDeleteRows = false;
            this.dgwSoba.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwSoba.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.BrojSprata,
            this.BrojSobe,
            this.OpisSobe,
            this.SobaStatus,
            this.Slika,
            this.Obrisi});
            this.dgwSoba.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwSoba.Location = new System.Drawing.Point(5, 34);
            this.dgwSoba.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwSoba.Name = "dgwSoba";
            this.dgwSoba.ReadOnly = true;
            this.dgwSoba.RowHeadersWidth = 62;
            this.dgwSoba.RowTemplate.Height = 45;
            this.dgwSoba.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwSoba.Size = new System.Drawing.Size(870, 672);
            this.dgwSoba.TabIndex = 0;
            this.dgwSoba.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwSoba_MouseDoubleClick);
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
            // BrojSprata
            // 
            this.BrojSprata.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.BrojSprata.DataPropertyName = "BrojSprata";
            this.BrojSprata.HeaderText = "Broj Sprata";
            this.BrojSprata.MinimumWidth = 8;
            this.BrojSprata.Name = "BrojSprata";
            this.BrojSprata.ReadOnly = true;
            // 
            // BrojSobe
            // 
            this.BrojSobe.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.BrojSobe.DataPropertyName = "BrojSobe";
            this.BrojSobe.HeaderText = "Broj Sobe";
            this.BrojSobe.MinimumWidth = 8;
            this.BrojSobe.Name = "BrojSobe";
            this.BrojSobe.ReadOnly = true;
            // 
            // OpisSobe
            // 
            this.OpisSobe.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.OpisSobe.DataPropertyName = "OpisSobe";
            this.OpisSobe.HeaderText = "Opis Sobe";
            this.OpisSobe.MinimumWidth = 8;
            this.OpisSobe.Name = "OpisSobe";
            this.OpisSobe.ReadOnly = true;
            // 
            // SobaStatus
            // 
            this.SobaStatus.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.SobaStatus.DataPropertyName = "SobaStatus";
            this.SobaStatus.HeaderText = "Soba Status";
            this.SobaStatus.MinimumWidth = 8;
            this.SobaStatus.Name = "SobaStatus";
            this.SobaStatus.ReadOnly = true;
            this.SobaStatus.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            // 
            // Slika
            // 
            this.Slika.DataPropertyName = "Slika";
            this.Slika.HeaderText = "Slika";
            this.Slika.ImageLayout = System.Windows.Forms.DataGridViewImageCellLayout.Stretch;
            this.Slika.MinimumWidth = 8;
            this.Slika.Name = "Slika";
            this.Slika.ReadOnly = true;
            this.Slika.Width = 150;
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
            // frmSobaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(925, 865);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmSobaPrikaz";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmSobaPrikaz";
            this.Load += new System.EventHandler(this.frmSobaPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwSoba)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwSoba;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn BrojSprata;
        private DataGridViewTextBoxColumn BrojSobe;
        private DataGridViewTextBoxColumn OpisSobe;
        private DataGridViewTextBoxColumn SobaStatus;
        private DataGridViewImageColumn Slika;
        private DataGridViewButtonColumn Obrisi;
    }
}