
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
            this.txtKorisnickoIme.Location = new System.Drawing.Point(207, 429);
            this.txtKorisnickoIme.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtKorisnickoIme.Name = "txtKorisnickoIme";
            this.txtKorisnickoIme.Size = new System.Drawing.Size(416, 31);
            this.txtKorisnickoIme.TabIndex = 81;
            this.txtKorisnickoIme.Validating += new System.ComponentModel.CancelEventHandler(this.txtKorisnickoIme_Validating);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label9.Location = new System.Drawing.Point(37, 431);
            this.label9.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(139, 25);
            this.label9.TabIndex = 80;
            this.label9.Text = "Korisnicko ime";
            // 
            // txtPotvrdiLozinku
            // 
            this.txtPotvrdiLozinku.Location = new System.Drawing.Point(207, 604);
            this.txtPotvrdiLozinku.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtPotvrdiLozinku.Name = "txtPotvrdiLozinku";
            this.txtPotvrdiLozinku.Size = new System.Drawing.Size(416, 31);
            this.txtPotvrdiLozinku.TabIndex = 79;
            // 
            // txtLozinka
            // 
            this.txtLozinka.Location = new System.Drawing.Point(207, 510);
            this.txtLozinka.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtLozinka.Name = "txtLozinka";
            this.txtLozinka.Size = new System.Drawing.Size(416, 31);
            this.txtLozinka.TabIndex = 78;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label8.Location = new System.Drawing.Point(37, 606);
            this.label8.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(138, 25);
            this.label8.TabIndex = 77;
            this.label8.Text = "Potvrdi lozinku";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label7.Location = new System.Drawing.Point(37, 515);
            this.label7.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(80, 25);
            this.label7.TabIndex = 76;
            this.label7.Text = "Lozinka";
            // 
            // pbOsoblje
            // 
            this.pbOsoblje.Location = new System.Drawing.Point(38, 683);
            this.pbOsoblje.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.pbOsoblje.Name = "pbOsoblje";
            this.pbOsoblje.Size = new System.Drawing.Size(393, 231);
            this.pbOsoblje.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbOsoblje.TabIndex = 75;
            this.pbOsoblje.TabStop = false;
            this.pbOsoblje.Validating += new System.ComponentModel.CancelEventHandler(this.pbOsoblje_Validating);
            // 
            // btnDodajSliku
            // 
            this.btnDodajSliku.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnDodajSliku.Location = new System.Drawing.Point(455, 683);
            this.btnDodajSliku.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnDodajSliku.Name = "btnDodajSliku";
            this.btnDodajSliku.Size = new System.Drawing.Size(165, 110);
            this.btnDodajSliku.TabIndex = 74;
            this.btnDodajSliku.Text = "Ucitaj sliku";
            this.btnDodajSliku.UseVisualStyleBackColor = true;
            this.btnDodajSliku.Click += new System.EventHandler(this.btnDodajSliku_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label6.Location = new System.Drawing.Point(38, 17);
            this.label6.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(334, 29);
            this.label6.TabIndex = 73;
            this.label6.Text = "Unesite podatke o uposlenom";
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnSnimi.Location = new System.Drawing.Point(495, 846);
            this.btnSnimi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(125, 67);
            this.btnSnimi.TabIndex = 72;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // txtEmail
            // 
            this.txtEmail.Location = new System.Drawing.Point(207, 346);
            this.txtEmail.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.Size = new System.Drawing.Size(416, 31);
            this.txtEmail.TabIndex = 71;
            this.txtEmail.Validating += new System.ComponentModel.CancelEventHandler(this.txtEmail_Validating);
            // 
            // txtTelefon
            // 
            this.txtTelefon.Location = new System.Drawing.Point(207, 263);
            this.txtTelefon.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtTelefon.Name = "txtTelefon";
            this.txtTelefon.Size = new System.Drawing.Size(416, 31);
            this.txtTelefon.TabIndex = 70;
            this.txtTelefon.Validating += new System.ComponentModel.CancelEventHandler(this.txtTelefon_Validating);
            // 
            // txtprezime
            // 
            this.txtprezime.Location = new System.Drawing.Point(207, 183);
            this.txtprezime.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtprezime.Name = "txtprezime";
            this.txtprezime.Size = new System.Drawing.Size(416, 31);
            this.txtprezime.TabIndex = 69;
            this.txtprezime.Validating += new System.ComponentModel.CancelEventHandler(this.txtprezime_Validating);
            // 
            // txtIme
            // 
            this.txtIme.Location = new System.Drawing.Point(207, 110);
            this.txtIme.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtIme.Name = "txtIme";
            this.txtIme.Size = new System.Drawing.Size(416, 31);
            this.txtIme.TabIndex = 68;
            this.txtIme.Validating += new System.ComponentModel.CancelEventHandler(this.txtIme_Validating);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label4.Location = new System.Drawing.Point(38, 112);
            this.label4.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(44, 25);
            this.label4.TabIndex = 67;
            this.label4.Text = "Ime";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label3.Location = new System.Drawing.Point(38, 352);
            this.label3.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(60, 25);
            this.label3.TabIndex = 66;
            this.label3.Text = "Email";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label2.Location = new System.Drawing.Point(38, 269);
            this.label2.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(78, 25);
            this.label2.TabIndex = 65;
            this.label2.Text = "Telefon";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(38, 188);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(83, 25);
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
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(683, 956);
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
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmOsobljeDetalji";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
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