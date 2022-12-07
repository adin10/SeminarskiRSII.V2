
namespace SeminarskiRSII.WinUI.Osoblje
{
    partial class frmOsobljePrikaz
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
            this.txtPrezime = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwOsoblje = new System.Windows.Forms.DataGridView();
            this.ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Ime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Prezime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Telefon = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.KorisnickoIme = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwOsoblje)).BeginInit();
            this.SuspendLayout();
            // 
            // txtPrezime
            // 
            this.txtPrezime.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPrezime.Location = new System.Drawing.Point(289, 62);
            this.txtPrezime.Name = "txtPrezime";
            this.txtPrezime.Size = new System.Drawing.Size(250, 23);
            this.txtPrezime.TabIndex = 27;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(286, 38);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(59, 17);
            this.label3.TabIndex = 26;
            this.label3.Text = "Prezime";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(13, 38);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(30, 17);
            this.label2.TabIndex = 25;
            this.label2.Text = "Ime";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 20);
            this.label1.TabIndex = 24;
            this.label1.Text = "Pretraga";
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikazi.Location = new System.Drawing.Point(558, 51);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(91, 38);
            this.btnPrikazi.TabIndex = 23;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPretraga.Location = new System.Drawing.Point(13, 62);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(250, 23);
            this.txtPretraga.TabIndex = 22;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwOsoblje);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(13, 109);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(649, 343);
            this.groupBox1.TabIndex = 21;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Pregled svih uposlenih";
            // 
            // dgwOsoblje
            // 
            this.dgwOsoblje.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwOsoblje.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ID,
            this.Ime,
            this.Prezime,
            this.Email,
            this.Telefon,
            this.KorisnickoIme});
            this.dgwOsoblje.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwOsoblje.Location = new System.Drawing.Point(3, 20);
            this.dgwOsoblje.Name = "dgwOsoblje";
            this.dgwOsoblje.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwOsoblje.Size = new System.Drawing.Size(643, 320);
            this.dgwOsoblje.TabIndex = 0;
            this.dgwOsoblje.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwOsoblje_MouseDoubleClick);
            // 
            // ID
            // 
            this.ID.DataPropertyName = "Id";
            this.ID.HeaderText = "ID";
            this.ID.Name = "ID";
            this.ID.Visible = false;
            // 
            // Ime
            // 
            this.Ime.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Ime.DataPropertyName = "Ime";
            this.Ime.HeaderText = "Ime";
            this.Ime.Name = "Ime";
            // 
            // Prezime
            // 
            this.Prezime.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Prezime.DataPropertyName = "Prezime";
            this.Prezime.HeaderText = "Prezime";
            this.Prezime.Name = "Prezime";
            // 
            // Email
            // 
            this.Email.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Email.DataPropertyName = "Email";
            this.Email.HeaderText = "Email";
            this.Email.Name = "Email";
            // 
            // Telefon
            // 
            this.Telefon.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Telefon.DataPropertyName = "Telefon";
            this.Telefon.HeaderText = "Telefon";
            this.Telefon.Name = "Telefon";
            // 
            // KorisnickoIme
            // 
            this.KorisnickoIme.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.KorisnickoIme.DataPropertyName = "KorisnickoIme";
            this.KorisnickoIme.HeaderText = "Korisnicko ime";
            this.KorisnickoIme.Name = "KorisnickoIme";
            // 
            // frmOsobljePrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(669, 450);
            this.Controls.Add(this.txtPrezime);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmOsobljePrikaz";
            this.Text = "frmOsobljePrikaz";
            this.Load += new System.EventHandler(this.frmOsobljePrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwOsoblje)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtPrezime;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwOsoblje;
        private System.Windows.Forms.DataGridViewTextBoxColumn ID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Prezime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Email;
        private System.Windows.Forms.DataGridViewTextBoxColumn Telefon;
        private System.Windows.Forms.DataGridViewTextBoxColumn KorisnickoIme;
    }
}