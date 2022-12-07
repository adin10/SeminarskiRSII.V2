
namespace SeminarskiRSII.WinUI.Grad
{
    partial class frmGradDetalji
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
            this.btnSnimi = new System.Windows.Forms.Button();
            this.cmbDrzave = new System.Windows.Forms.ComboBox();
            this.txtPostanskiBroj = new System.Windows.Forms.TextBox();
            this.txtNaziv = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.lbl1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(37, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(184, 20);
            this.label1.TabIndex = 31;
            this.label1.Text = "Unesite podatke o gradu";
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(298, 242);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(98, 34);
            this.btnSnimi.TabIndex = 30;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // cmbDrzave
            // 
            this.cmbDrzave.FormattingEnabled = true;
            this.cmbDrzave.Location = new System.Drawing.Point(147, 187);
            this.cmbDrzave.Name = "cmbDrzave";
            this.cmbDrzave.Size = new System.Drawing.Size(249, 21);
            this.cmbDrzave.TabIndex = 29;
            // 
            // txtPostanskiBroj
            // 
            this.txtPostanskiBroj.Location = new System.Drawing.Point(147, 137);
            this.txtPostanskiBroj.Name = "txtPostanskiBroj";
            this.txtPostanskiBroj.Size = new System.Drawing.Size(249, 20);
            this.txtPostanskiBroj.TabIndex = 28;
            // 
            // txtNaziv
            // 
            this.txtNaziv.Location = new System.Drawing.Point(147, 85);
            this.txtNaziv.Name = "txtNaziv";
            this.txtNaziv.Size = new System.Drawing.Size(249, 20);
            this.txtNaziv.TabIndex = 27;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(38, 191);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(53, 17);
            this.label3.TabIndex = 26;
            this.label3.Text = "Drzava";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(38, 137);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(97, 17);
            this.label2.TabIndex = 25;
            this.label2.Text = "Postanski broj";
            // 
            // lbl1
            // 
            this.lbl1.AutoSize = true;
            this.lbl1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl1.Location = new System.Drawing.Point(38, 85);
            this.lbl1.Name = "lbl1";
            this.lbl1.Size = new System.Drawing.Size(84, 17);
            this.lbl1.TabIndex = 24;
            this.lbl1.Text = "Naziv grada";
            // 
            // frmGradDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(429, 352);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.cmbDrzave);
            this.Controls.Add(this.txtPostanskiBroj);
            this.Controls.Add(this.txtNaziv);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.lbl1);
            this.Name = "frmGradDetalji";
            this.Text = "frmGradDetalji";
            this.Load += new System.EventHandler(this.frmGradDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.ComboBox cmbDrzave;
        private System.Windows.Forms.TextBox txtPostanskiBroj;
        private System.Windows.Forms.TextBox txtNaziv;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lbl1;
    }
}