
namespace SeminarskiRSII.WinUI.VrstaOsoblja
{
    partial class frmVrstaOsobljaDetalji
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
            this.btnSnimi = new System.Windows.Forms.Button();
            this.txtZaduzenja = new System.Windows.Forms.TextBox();
            this.txtPozicija = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(39, 35);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(158, 20);
            this.label3.TabIndex = 23;
            this.label3.Text = "Pozicija i radni zadaci";
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(301, 212);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 28);
            this.btnSnimi.TabIndex = 22;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // txtZaduzenja
            // 
            this.txtZaduzenja.Location = new System.Drawing.Point(124, 152);
            this.txtZaduzenja.Name = "txtZaduzenja";
            this.txtZaduzenja.Size = new System.Drawing.Size(252, 20);
            this.txtZaduzenja.TabIndex = 21;
            // 
            // txtPozicija
            // 
            this.txtPozicija.Location = new System.Drawing.Point(124, 99);
            this.txtPozicija.Name = "txtPozicija";
            this.txtPozicija.Size = new System.Drawing.Size(252, 20);
            this.txtPozicija.TabIndex = 20;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(36, 152);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(75, 17);
            this.label2.TabIndex = 19;
            this.label2.Text = "Zaduzenja";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(36, 99);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 17);
            this.label1.TabIndex = 18;
            this.label1.Text = "Pozicija";
            // 
            // frmVrstaOsobljaDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(424, 296);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.txtZaduzenja);
            this.Controls.Add(this.txtPozicija);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmVrstaOsobljaDetalji";
            this.Text = "frmVrstaOsobljaDetalji";
            this.Load += new System.EventHandler(this.frmVrstaOsobljaDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.TextBox txtZaduzenja;
        private System.Windows.Forms.TextBox txtPozicija;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}