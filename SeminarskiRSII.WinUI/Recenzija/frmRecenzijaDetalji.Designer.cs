
namespace SeminarskiRSII.WinUI.Recenzija
{
    partial class frmRecenzijaDetalji
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
            this.cmbSoba = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.btnSnimi = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.txtKomentar = new System.Windows.Forms.TextBox();
            this.txtOcjena = new System.Windows.Forms.TextBox();
            this.cmbGost = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // cmbSoba
            // 
            this.cmbSoba.FormattingEnabled = true;
            this.cmbSoba.Location = new System.Drawing.Point(119, 139);
            this.cmbSoba.Name = "cmbSoba";
            this.cmbSoba.Size = new System.Drawing.Size(241, 21);
            this.cmbSoba.TabIndex = 37;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(31, 139);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(41, 17);
            this.label5.TabIndex = 36;
            this.label5.Text = "Soba";
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(285, 274);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 31);
            this.btnSnimi.TabIndex = 35;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(30, 36);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(118, 20);
            this.label4.TabIndex = 34;
            this.label4.Text = "Dodaj recenziju";
            // 
            // txtKomentar
            // 
            this.txtKomentar.Location = new System.Drawing.Point(119, 224);
            this.txtKomentar.Name = "txtKomentar";
            this.txtKomentar.Size = new System.Drawing.Size(241, 20);
            this.txtKomentar.TabIndex = 33;
            // 
            // txtOcjena
            // 
            this.txtOcjena.Location = new System.Drawing.Point(119, 177);
            this.txtOcjena.Name = "txtOcjena";
            this.txtOcjena.Size = new System.Drawing.Size(241, 20);
            this.txtOcjena.TabIndex = 32;
            // 
            // cmbGost
            // 
            this.cmbGost.FormattingEnabled = true;
            this.cmbGost.Location = new System.Drawing.Point(119, 97);
            this.cmbGost.Name = "cmbGost";
            this.cmbGost.Size = new System.Drawing.Size(241, 21);
            this.cmbGost.TabIndex = 31;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(31, 227);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(69, 17);
            this.label3.TabIndex = 30;
            this.label3.Text = "Komentar";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(31, 180);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 17);
            this.label2.TabIndex = 29;
            this.label2.Text = "Ocjena";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(31, 98);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(38, 17);
            this.label1.TabIndex = 28;
            this.label1.Text = "Gost";
            // 
            // frmRecenzijaDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(396, 365);
            this.Controls.Add(this.cmbSoba);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtKomentar);
            this.Controls.Add(this.txtOcjena);
            this.Controls.Add(this.cmbGost);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmRecenzijaDetalji";
            this.Text = "frmRecenzijaDetalji";
            this.Load += new System.EventHandler(this.frmRecenzijaDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cmbSoba;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtKomentar;
        private System.Windows.Forms.TextBox txtOcjena;
        private System.Windows.Forms.ComboBox cmbGost;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}