
namespace SeminarskiRSII.WinUI.Rezervacija
{
    partial class frmRezervacijaDetalji
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
            this.dtpZavrsetak = new System.Windows.Forms.DateTimePicker();
            this.dtpPocetak = new System.Windows.Forms.DateTimePicker();
            this.cmbSoba = new System.Windows.Forms.ComboBox();
            this.cmbGost = new System.Windows.Forms.ComboBox();
            this.btnSnimi = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // dtpZavrsetak
            // 
            this.dtpZavrsetak.Location = new System.Drawing.Point(300, 440);
            this.dtpZavrsetak.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dtpZavrsetak.Name = "dtpZavrsetak";
            this.dtpZavrsetak.Size = new System.Drawing.Size(426, 31);
            this.dtpZavrsetak.TabIndex = 43;
            // 
            // dtpPocetak
            // 
            this.dtpPocetak.Location = new System.Drawing.Point(300, 342);
            this.dtpPocetak.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dtpPocetak.Name = "dtpPocetak";
            this.dtpPocetak.Size = new System.Drawing.Size(426, 31);
            this.dtpPocetak.TabIndex = 42;
            // 
            // cmbSoba
            // 
            this.cmbSoba.FormattingEnabled = true;
            this.cmbSoba.Location = new System.Drawing.Point(300, 250);
            this.cmbSoba.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.cmbSoba.Name = "cmbSoba";
            this.cmbSoba.Size = new System.Drawing.Size(426, 33);
            this.cmbSoba.TabIndex = 41;
            // 
            // cmbGost
            // 
            this.cmbGost.FormattingEnabled = true;
            this.cmbGost.Location = new System.Drawing.Point(300, 160);
            this.cmbGost.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.cmbGost.Name = "cmbGost";
            this.cmbGost.Size = new System.Drawing.Size(426, 33);
            this.cmbGost.TabIndex = 40;
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnSnimi.Location = new System.Drawing.Point(603, 544);
            this.btnSnimi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(125, 56);
            this.btnSnimi.TabIndex = 39;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label5.Location = new System.Drawing.Point(50, 440);
            this.label5.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(197, 25);
            this.label5.TabIndex = 38;
            this.label5.Text = "Zavrsetak rezervacije";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label4.Location = new System.Drawing.Point(52, 342);
            this.label4.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(168, 25);
            this.label4.TabIndex = 37;
            this.label4.Text = "Datum rezervacije";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label3.Location = new System.Drawing.Point(55, 258);
            this.label3.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(59, 25);
            this.label3.TabIndex = 36;
            this.label3.Text = "Soba";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label2.Location = new System.Drawing.Point(52, 160);
            this.label2.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 25);
            this.label2.TabIndex = 35;
            this.label2.Text = "Gost";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(50, 46);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(256, 29);
            this.label1.TabIndex = 34;
            this.label1.Text = "Dodaj novu rezervaciju";
            // 
            // frmRezervacijaDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(773, 729);
            this.Controls.Add(this.dtpZavrsetak);
            this.Controls.Add(this.dtpPocetak);
            this.Controls.Add(this.cmbSoba);
            this.Controls.Add(this.cmbGost);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmRezervacijaDetalji";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmRezervacijaDetalji";
            this.Load += new System.EventHandler(this.frmRezervacijaDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dtpZavrsetak;
        private System.Windows.Forms.DateTimePicker dtpPocetak;
        private System.Windows.Forms.ComboBox cmbSoba;
        private System.Windows.Forms.ComboBox cmbGost;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}