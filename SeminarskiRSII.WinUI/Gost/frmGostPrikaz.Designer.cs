
namespace SeminarskiRSII.WinUI.Gost
{
    partial class frmGostPrikaz
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
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.txtPrezime = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwGosti = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Ime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Prezime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Telefon = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Grad = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.KorisnickoIme = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwGosti)).BeginInit();
            this.SuspendLayout();
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(16, 46);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(30, 17);
            this.label3.TabIndex = 27;
            this.label3.Text = "Ime";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(300, 46);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(59, 17);
            this.label2.TabIndex = 26;
            this.label2.Text = "Prezime";
            // 
            // txtPrezime
            // 
            this.txtPrezime.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPrezime.Location = new System.Drawing.Point(303, 66);
            this.txtPrezime.Name = "txtPrezime";
            this.txtPrezime.Size = new System.Drawing.Size(241, 23);
            this.txtPrezime.TabIndex = 25;
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
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPretraga.Location = new System.Drawing.Point(16, 66);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(241, 23);
            this.txtPretraga.TabIndex = 23;
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikazi.Location = new System.Drawing.Point(570, 55);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(90, 42);
            this.btnPrikazi.TabIndex = 22;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwGosti);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 103);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(651, 336);
            this.groupBox1.TabIndex = 21;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Gosti";
            // 
            // dgwGosti
            // 
            this.dgwGosti.AllowUserToAddRows = false;
            this.dgwGosti.AllowUserToDeleteRows = false;
            this.dgwGosti.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwGosti.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Ime,
            this.Prezime,
            this.Email,
            this.Telefon,
            this.Grad,
            this.KorisnickoIme});
            this.dgwGosti.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwGosti.Location = new System.Drawing.Point(3, 20);
            this.dgwGosti.Name = "dgwGosti";
            this.dgwGosti.ReadOnly = true;
            this.dgwGosti.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwGosti.Size = new System.Drawing.Size(645, 313);
            this.dgwGosti.TabIndex = 0;
            this.dgwGosti.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwGosti_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            // 
            // Ime
            // 
            this.Ime.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Ime.DataPropertyName = "Ime";
            this.Ime.HeaderText = "Ime";
            this.Ime.Name = "Ime";
            this.Ime.ReadOnly = true;
            // 
            // Prezime
            // 
            this.Prezime.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Prezime.DataPropertyName = "Prezime";
            this.Prezime.HeaderText = "Prezime";
            this.Prezime.Name = "Prezime";
            this.Prezime.ReadOnly = true;
            // 
            // Email
            // 
            this.Email.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Email.DataPropertyName = "Email";
            this.Email.HeaderText = "Email";
            this.Email.Name = "Email";
            this.Email.ReadOnly = true;
            // 
            // Telefon
            // 
            this.Telefon.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Telefon.DataPropertyName = "Telefon";
            this.Telefon.HeaderText = "Telefon";
            this.Telefon.Name = "Telefon";
            this.Telefon.ReadOnly = true;
            // 
            // Grad
            // 
            this.Grad.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Grad.DataPropertyName = "Grad";
            this.Grad.HeaderText = "Grad";
            this.Grad.Name = "Grad";
            this.Grad.ReadOnly = true;
            // 
            // KorisnickoIme
            // 
            this.KorisnickoIme.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.KorisnickoIme.DataPropertyName = "KorisnickoIme";
            this.KorisnickoIme.HeaderText = "Korisnicko ime";
            this.KorisnickoIme.Name = "KorisnickoIme";
            this.KorisnickoIme.ReadOnly = true;
            // 
            // frmGostPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(672, 450);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtPrezime);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmGostPrikaz";
            this.Text = "frmGostPrikaz";
            this.Load += new System.EventHandler(this.frmGostPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwGosti)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtPrezime;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwGosti;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Prezime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Email;
        private System.Windows.Forms.DataGridViewTextBoxColumn Telefon;
        private System.Windows.Forms.DataGridViewTextBoxColumn Grad;
        private System.Windows.Forms.DataGridViewTextBoxColumn KorisnickoIme;
    }
}