
namespace SeminarskiRSII.WinUI.Recenzija
{
    partial class frmRecenzijaPrikaz
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
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwRecenzija = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Gost = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Soba = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Ocjena = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Komentar = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwRecenzija)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 20);
            this.label1.TabIndex = 15;
            this.label1.Text = "Pretraga";
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikazi.Location = new System.Drawing.Point(508, 35);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(75, 35);
            this.btnPrikazi.TabIndex = 14;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPretraga.Location = new System.Drawing.Point(12, 42);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(482, 23);
            this.txtPretraga.TabIndex = 13;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwRecenzija);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(9, 88);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(584, 358);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista ocjena i komentara posjetilaca";
            // 
            // dgwRecenzija
            // 
            this.dgwRecenzija.AllowUserToAddRows = false;
            this.dgwRecenzija.AllowUserToDeleteRows = false;
            this.dgwRecenzija.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwRecenzija.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Gost,
            this.Soba,
            this.Ocjena,
            this.Komentar});
            this.dgwRecenzija.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwRecenzija.Location = new System.Drawing.Point(3, 22);
            this.dgwRecenzija.Name = "dgwRecenzija";
            this.dgwRecenzija.ReadOnly = true;
            this.dgwRecenzija.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwRecenzija.Size = new System.Drawing.Size(578, 333);
            this.dgwRecenzija.TabIndex = 0;
            this.dgwRecenzija.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwRecenzija_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            // 
            // Gost
            // 
            this.Gost.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Gost.DataPropertyName = "gost";
            this.Gost.HeaderText = "Gost";
            this.Gost.Name = "Gost";
            this.Gost.ReadOnly = true;
            // 
            // Soba
            // 
            this.Soba.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Soba.DataPropertyName = "soba";
            this.Soba.HeaderText = "Soba broj";
            this.Soba.Name = "Soba";
            this.Soba.ReadOnly = true;
            // 
            // Ocjena
            // 
            this.Ocjena.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Ocjena.DataPropertyName = "Ocjena";
            this.Ocjena.HeaderText = "Ocjena";
            this.Ocjena.Name = "Ocjena";
            this.Ocjena.ReadOnly = true;
            // 
            // Komentar
            // 
            this.Komentar.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Komentar.DataPropertyName = "Komentar";
            this.Komentar.HeaderText = "Komentar";
            this.Komentar.Name = "Komentar";
            this.Komentar.ReadOnly = true;
            // 
            // frmRecenzijaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(607, 450);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmRecenzijaPrikaz";
            this.Text = "frmRecenzijaPrikaz";
            this.Load += new System.EventHandler(this.frmRecenzijaPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwRecenzija)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwRecenzija;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Gost;
        private System.Windows.Forms.DataGridViewTextBoxColumn Soba;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ocjena;
        private System.Windows.Forms.DataGridViewTextBoxColumn Komentar;
    }
}