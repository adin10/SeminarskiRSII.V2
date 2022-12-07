
namespace SeminarskiRSII.WinUI.SobaOsoblje
{
    partial class frmSobaOsobljeDetalji
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
            this.btnSnimi = new System.Windows.Forms.Button();
            this.cmbSoba = new System.Windows.Forms.ComboBox();
            this.cmbOsoblje = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(274, 224);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 31);
            this.btnSnimi.TabIndex = 24;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // cmbSoba
            // 
            this.cmbSoba.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbSoba.FormattingEnabled = true;
            this.cmbSoba.Location = new System.Drawing.Point(114, 161);
            this.cmbSoba.Name = "cmbSoba";
            this.cmbSoba.Size = new System.Drawing.Size(235, 24);
            this.cmbSoba.TabIndex = 23;
            // 
            // cmbOsoblje
            // 
            this.cmbOsoblje.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbOsoblje.FormattingEnabled = true;
            this.cmbOsoblje.Location = new System.Drawing.Point(114, 99);
            this.cmbOsoblje.Name = "cmbOsoblje";
            this.cmbOsoblje.Size = new System.Drawing.Size(235, 24);
            this.cmbOsoblje.TabIndex = 22;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(38, 102);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(56, 17);
            this.label4.TabIndex = 21;
            this.label4.Text = "Osoblje";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(38, 164);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(41, 17);
            this.label3.TabIndex = 20;
            this.label3.Text = "Soba";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(37, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(176, 20);
            this.label1.TabIndex = 19;
            this.label1.Text = "Zaduzi uposleniku sobu";
            // 
            // frmSobaOsobljeDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(381, 311);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.cmbSoba);
            this.Controls.Add(this.cmbOsoblje);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Name = "frmSobaOsobljeDetalji";
            this.Text = "frmSobaOsobljeDetalji";
            this.Load += new System.EventHandler(this.frmSobaOsobljeDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.ComboBox cmbSoba;
        private System.Windows.Forms.ComboBox cmbOsoblje;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
    }
}