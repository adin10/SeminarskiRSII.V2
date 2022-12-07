
namespace SeminarskiRSII.WinUI.Grad
{
    partial class frmGradPrikaz
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
            this.txtpretraga = new System.Windows.Forms.TextBox();
            this.btnPrikaz = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwGradovi = new System.Windows.Forms.DataGridView();
            this.GradID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NazivGrada = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PostanskiBroj = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Drzava = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwGradovi)).BeginInit();
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
            // txtpretraga
            // 
            this.txtpretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtpretraga.Location = new System.Drawing.Point(16, 47);
            this.txtpretraga.Name = "txtpretraga";
            this.txtpretraga.Size = new System.Drawing.Size(368, 23);
            this.txtpretraga.TabIndex = 14;
            // 
            // btnPrikaz
            // 
            this.btnPrikaz.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikaz.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikaz.Location = new System.Drawing.Point(413, 38);
            this.btnPrikaz.Name = "btnPrikaz";
            this.btnPrikaz.Size = new System.Drawing.Size(93, 38);
            this.btnPrikaz.TabIndex = 13;
            this.btnPrikaz.Text = "Prikazi";
            this.btnPrikaz.UseVisualStyleBackColor = false;
            this.btnPrikaz.Click += new System.EventHandler(this.btnPrikaz_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwGradovi);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 80);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(497, 356);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista gradova";
            // 
            // dgwGradovi
            // 
            this.dgwGradovi.AllowUserToAddRows = false;
            this.dgwGradovi.AllowUserToDeleteRows = false;
            this.dgwGradovi.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwGradovi.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.GradID,
            this.NazivGrada,
            this.PostanskiBroj,
            this.Drzava});
            this.dgwGradovi.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwGradovi.Location = new System.Drawing.Point(3, 20);
            this.dgwGradovi.Name = "dgwGradovi";
            this.dgwGradovi.ReadOnly = true;
            this.dgwGradovi.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwGradovi.Size = new System.Drawing.Size(491, 333);
            this.dgwGradovi.TabIndex = 0;
            this.dgwGradovi.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwGradovi_MouseDoubleClick);
            // 
            // GradID
            // 
            this.GradID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.GradID.DataPropertyName = "Id";
            this.GradID.HeaderText = "GradID";
            this.GradID.Name = "GradID";
            this.GradID.ReadOnly = true;
            this.GradID.Visible = false;
            // 
            // NazivGrada
            // 
            this.NazivGrada.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.NazivGrada.DataPropertyName = "NazivGrada";
            this.NazivGrada.HeaderText = "Naziv Grada";
            this.NazivGrada.Name = "NazivGrada";
            this.NazivGrada.ReadOnly = true;
            // 
            // PostanskiBroj
            // 
            this.PostanskiBroj.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.PostanskiBroj.DataPropertyName = "PostanskiBroj";
            this.PostanskiBroj.HeaderText = "Postanski Broj";
            this.PostanskiBroj.Name = "PostanskiBroj";
            this.PostanskiBroj.ReadOnly = true;
            // 
            // Drzava
            // 
            this.Drzava.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Drzava.DataPropertyName = "drzava";
            this.Drzava.HeaderText = "Drzava";
            this.Drzava.Name = "Drzava";
            this.Drzava.ReadOnly = true;
            // 
            // frmGradPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(520, 450);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtpretraga);
            this.Controls.Add(this.btnPrikaz);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmGradPrikaz";
            this.Text = "frmGradPrikaz";
            this.Load += new System.EventHandler(this.frmGradPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwGradovi)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtpretraga;
        private System.Windows.Forms.Button btnPrikaz;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwGradovi;
        private System.Windows.Forms.DataGridViewTextBoxColumn GradID;
        private System.Windows.Forms.DataGridViewTextBoxColumn NazivGrada;
        private System.Windows.Forms.DataGridViewTextBoxColumn PostanskiBroj;
        private System.Windows.Forms.DataGridViewTextBoxColumn Drzava;
    }
}