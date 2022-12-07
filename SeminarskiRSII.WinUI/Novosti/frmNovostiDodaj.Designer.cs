
namespace SeminarskiRSII.WinUI.Novosti
{
    partial class frmNovostiDodaj
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
            this.dtpDatum = new System.Windows.Forms.DateTimePicker();
            this.btnSnimi = new System.Windows.Forms.Button();
            this.cmbAutor = new System.Windows.Forms.ComboBox();
            this.txtSadrzaj = new System.Windows.Forms.TextBox();
            this.txtNaslov = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // dtpDatum
            // 
            this.dtpDatum.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpDatum.Location = new System.Drawing.Point(138, 203);
            this.dtpDatum.Name = "dtpDatum";
            this.dtpDatum.Size = new System.Drawing.Size(283, 23);
            this.dtpDatum.TabIndex = 40;
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(338, 326);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(83, 34);
            this.btnSnimi.TabIndex = 39;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // cmbAutor
            // 
            this.cmbAutor.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbAutor.FormattingEnabled = true;
            this.cmbAutor.Location = new System.Drawing.Point(138, 267);
            this.cmbAutor.Name = "cmbAutor";
            this.cmbAutor.Size = new System.Drawing.Size(283, 24);
            this.cmbAutor.TabIndex = 38;
            // 
            // txtSadrzaj
            // 
            this.txtSadrzaj.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtSadrzaj.Location = new System.Drawing.Point(138, 142);
            this.txtSadrzaj.Name = "txtSadrzaj";
            this.txtSadrzaj.Size = new System.Drawing.Size(283, 23);
            this.txtSadrzaj.TabIndex = 37;
            // 
            // txtNaslov
            // 
            this.txtNaslov.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtNaslov.Location = new System.Drawing.Point(138, 85);
            this.txtNaslov.Name = "txtNaslov";
            this.txtNaslov.Size = new System.Drawing.Size(283, 23);
            this.txtNaslov.TabIndex = 36;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(29, 270);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(91, 17);
            this.label5.TabIndex = 35;
            this.label5.Text = "Vijest objavio";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(29, 208);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(101, 17);
            this.label4.TabIndex = 34;
            this.label4.Text = "Vrijeme objave";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(29, 145);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 17);
            this.label3.TabIndex = 33;
            this.label3.Text = "Sadrzaj";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(28, 22);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(117, 20);
            this.label2.TabIndex = 32;
            this.label2.Text = "Dodaj obavijest";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(29, 88);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(51, 17);
            this.label1.TabIndex = 31;
            this.label1.Text = "Naslov";
            // 
            // frmNovostiDodaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(443, 450);
            this.Controls.Add(this.dtpDatum);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.cmbAutor);
            this.Controls.Add(this.txtSadrzaj);
            this.Controls.Add(this.txtNaslov);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmNovostiDodaj";
            this.Text = "frmNovostiDodaj";
            this.Load += new System.EventHandler(this.frmNovostiDodaj_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dtpDatum;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.ComboBox cmbAutor;
        private System.Windows.Forms.TextBox txtSadrzaj;
        private System.Windows.Forms.TextBox txtNaslov;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}