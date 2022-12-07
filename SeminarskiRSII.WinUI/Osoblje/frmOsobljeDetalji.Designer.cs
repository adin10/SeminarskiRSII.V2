
namespace SeminarskiRSII.WinUI.Osoblje
{
    partial class frmOsobljeDetalji
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
            this.txtKorisnickoIme = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.txtPotvrdiLozinku = new System.Windows.Forms.TextBox();
            this.txtLozinka = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.pbOsoblje = new System.Windows.Forms.PictureBox();
            this.btnDodajSliku = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.btnSnimi = new System.Windows.Forms.Button();
            this.txtEmail = new System.Windows.Forms.TextBox();
            this.txtTelefon = new System.Windows.Forms.TextBox();
            this.txtprezime = new System.Windows.Forms.TextBox();
            this.txtIme = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.pbOsoblje)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
            this.SuspendLayout();
            // 
            // txtKorisnickoIme
            // 
            this.txtKorisnickoIme.Location = new System.Drawing.Point(124, 223);
            this.txtKorisnickoIme.Name = "txtKorisnickoIme";
            this.txtKorisnickoIme.Size = new System.Drawing.Size(251, 20);
            this.txtKorisnickoIme.TabIndex = 81;
            this.txtKorisnickoIme.Validating += new System.ComponentModel.CancelEventHandler(this.txtKorisnickoIme_Validating);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(22, 224);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(99, 17);
            this.label9.TabIndex = 80;
            this.label9.Text = "Korisnicko ime";
            // 
            // txtPotvrdiLozinku
            // 
            this.txtPotvrdiLozinku.Location = new System.Drawing.Point(124, 314);
            this.txtPotvrdiLozinku.Name = "txtPotvrdiLozinku";
            this.txtPotvrdiLozinku.Size = new System.Drawing.Size(251, 20);
            this.txtPotvrdiLozinku.TabIndex = 79;
            // 
            // txtLozinka
            // 
            this.txtLozinka.Location = new System.Drawing.Point(124, 265);
            this.txtLozinka.Name = "txtLozinka";
            this.txtLozinka.Size = new System.Drawing.Size(251, 20);
            this.txtLozinka.TabIndex = 78;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(22, 315);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(100, 17);
            this.label8.TabIndex = 77;
            this.label8.Text = "Potvrdi lozinku";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(22, 268);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(57, 17);
            this.label7.TabIndex = 76;
            this.label7.Text = "Lozinka";
            // 
            // pbOsoblje
            // 
            this.pbOsoblje.Location = new System.Drawing.Point(23, 355);
            this.pbOsoblje.Name = "pbOsoblje";
            this.pbOsoblje.Size = new System.Drawing.Size(236, 120);
            this.pbOsoblje.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbOsoblje.TabIndex = 75;
            this.pbOsoblje.TabStop = false;
            this.pbOsoblje.Validating += new System.ComponentModel.CancelEventHandler(this.pbOsoblje_Validating);
            // 
            // btnDodajSliku
            // 
            this.btnDodajSliku.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDodajSliku.Location = new System.Drawing.Point(273, 355);
            this.btnDodajSliku.Name = "btnDodajSliku";
            this.btnDodajSliku.Size = new System.Drawing.Size(99, 57);
            this.btnDodajSliku.TabIndex = 74;
            this.btnDodajSliku.Text = "Ucitaj sliku";
            this.btnDodajSliku.UseVisualStyleBackColor = true;
            this.btnDodajSliku.Click += new System.EventHandler(this.btnDodajSliku_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(23, 9);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(221, 20);
            this.label6.TabIndex = 73;
            this.label6.Text = "Unesite podatke o uposlenom";
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(297, 440);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 35);
            this.btnSnimi.TabIndex = 72;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // txtEmail
            // 
            this.txtEmail.Location = new System.Drawing.Point(124, 180);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.Size = new System.Drawing.Size(251, 20);
            this.txtEmail.TabIndex = 71;
            this.txtEmail.Validating += new System.ComponentModel.CancelEventHandler(this.txtEmail_Validating);
            // 
            // txtTelefon
            // 
            this.txtTelefon.Location = new System.Drawing.Point(124, 137);
            this.txtTelefon.Name = "txtTelefon";
            this.txtTelefon.Size = new System.Drawing.Size(251, 20);
            this.txtTelefon.TabIndex = 70;
            this.txtTelefon.Validating += new System.ComponentModel.CancelEventHandler(this.txtTelefon_Validating);
            // 
            // txtprezime
            // 
            this.txtprezime.Location = new System.Drawing.Point(124, 95);
            this.txtprezime.Name = "txtprezime";
            this.txtprezime.Size = new System.Drawing.Size(251, 20);
            this.txtprezime.TabIndex = 69;
            this.txtprezime.Validating += new System.ComponentModel.CancelEventHandler(this.txtprezime_Validating);
            // 
            // txtIme
            // 
            this.txtIme.Location = new System.Drawing.Point(124, 57);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(251, 20);
            this.txtIme.TabIndex = 68;
            this.txtIme.Validating += new System.ComponentModel.CancelEventHandler(this.txtIme_Validating);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(23, 58);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(30, 17);
            this.label4.TabIndex = 67;
            this.label4.Text = "Ime";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(23, 183);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(42, 17);
            this.label3.TabIndex = 66;
            this.label3.Text = "Email";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(23, 140);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 17);
            this.label2.TabIndex = 65;
            this.label2.Text = "Telefon";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(23, 98);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(59, 17);
            this.label1.TabIndex = 64;
            this.label1.Text = "Prezime";
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog1";
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // frmOsobljeDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(410, 497);
            this.Controls.Add(this.txtKorisnickoIme);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.txtPotvrdiLozinku);
            this.Controls.Add(this.txtLozinka);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.pbOsoblje);
            this.Controls.Add(this.btnDodajSliku);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.txtEmail);
            this.Controls.Add(this.txtTelefon);
            this.Controls.Add(this.txtprezime);
            this.Controls.Add(this.txtIme);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmOsobljeDetalji";
            this.Text = "frmOsobljeDetalji";
            this.Load += new System.EventHandler(this.frmOsobljeDetalji_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pbOsoblje)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtKorisnickoIme;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox txtPotvrdiLozinku;
        private System.Windows.Forms.TextBox txtLozinka;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.PictureBox pbOsoblje;
        private System.Windows.Forms.Button btnDodajSliku;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.TextBox txtEmail;
        private System.Windows.Forms.TextBox txtTelefon;
        private System.Windows.Forms.TextBox txtprezime;
        private System.Windows.Forms.TextBox txtIme;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.ErrorProvider errorProvider;
    }
}