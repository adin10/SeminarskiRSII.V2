
namespace SeminarskiRSII.WinUI.Izvjestaji
{
    partial class frmRecenzijeIzvjestaj
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnOdaberi = new System.Windows.Forms.Button();
            this.cbSobe = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnOdaberi);
            this.groupBox1.Controls.Add(this.cbSobe);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(283, 192);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Kreirajte izvjestaj";
            // 
            // btnOdaberi
            // 
            this.btnOdaberi.Location = new System.Drawing.Point(182, 141);
            this.btnOdaberi.Name = "btnOdaberi";
            this.btnOdaberi.Size = new System.Drawing.Size(91, 32);
            this.btnOdaberi.TabIndex = 2;
            this.btnOdaberi.Text = "Odaberi";
            this.btnOdaberi.UseVisualStyleBackColor = true;
            this.btnOdaberi.Click += new System.EventHandler(this.btnOdaberi_Click);
            // 
            // cbSobe
            // 
            this.cbSobe.FormattingEnabled = true;
            this.cbSobe.Location = new System.Drawing.Point(19, 76);
            this.cbSobe.Name = "cbSobe";
            this.cbSobe.Size = new System.Drawing.Size(260, 28);
            this.cbSobe.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(16, 45);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(106, 17);
            this.label1.TabIndex = 0;
            this.label1.Text = "Odaberite sobu";
            // 
            // frmRecenzijeIzvjestaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(309, 207);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmRecenzijeIzvjestaj";
            this.Text = "frmRecenzijeIzvjestaj";
            this.Load += new System.EventHandler(this.frmRecenzijeIzvjestaj_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnOdaberi;
        private System.Windows.Forms.ComboBox cbSobe;
        private System.Windows.Forms.Label label1;
    }
}