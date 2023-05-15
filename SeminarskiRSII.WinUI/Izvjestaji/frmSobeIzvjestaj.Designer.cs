
namespace SeminarskiRSII.WinUI.Izvjestaji
{
    partial class frmSobeIzvjestaj
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
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(-2, 23);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(474, 369);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Kreirajte izvjestaj";
            // 
            // btnOdaberi
            // 
            this.btnOdaberi.Location = new System.Drawing.Point(303, 271);
            this.btnOdaberi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnOdaberi.Name = "btnOdaberi";
            this.btnOdaberi.Size = new System.Drawing.Size(152, 62);
            this.btnOdaberi.TabIndex = 2;
            this.btnOdaberi.Text = "Odaberi";
            this.btnOdaberi.UseVisualStyleBackColor = true;
            this.btnOdaberi.Click += new System.EventHandler(this.btnOdaberi_Click);
            // 
            // cbSobe
            // 
            this.cbSobe.FormattingEnabled = true;
            this.cbSobe.Location = new System.Drawing.Point(32, 146);
            this.cbSobe.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.cbSobe.Name = "cbSobe";
            this.cbSobe.Size = new System.Drawing.Size(431, 37);
            this.cbSobe.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(27, 87);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(146, 25);
            this.label1.TabIndex = 0;
            this.label1.Text = "Odaberite sobu";
            // 
            // frmSobeIzvjestaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(479, 400);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmSobeIzvjestaj";
            this.Text = "frmSobeIzvjestaj";
            this.Load += new System.EventHandler(this.frmSobeIzvjestaj_Load);
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