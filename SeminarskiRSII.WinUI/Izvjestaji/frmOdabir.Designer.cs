
namespace SeminarskiRSII.WinUI.Izvjestaji
{
    partial class frmOdabir
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
            this.btnRecenzije = new System.Windows.Forms.Button();
            this.btnGosti = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnRecenzije
            // 
            this.btnRecenzije.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnRecenzije.Location = new System.Drawing.Point(62, 198);
            this.btnRecenzije.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnRecenzije.Name = "btnRecenzije";
            this.btnRecenzije.Size = new System.Drawing.Size(422, 113);
            this.btnRecenzije.TabIndex = 0;
            this.btnRecenzije.Text = "Pregled svih recenzija";
            this.btnRecenzije.UseVisualStyleBackColor = true;
            this.btnRecenzije.Click += new System.EventHandler(this.btnRecenzije_Click);
            // 
            // btnGosti
            // 
            this.btnGosti.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnGosti.Location = new System.Drawing.Point(62, 323);
            this.btnGosti.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnGosti.Name = "btnGosti";
            this.btnGosti.Size = new System.Drawing.Size(422, 113);
            this.btnGosti.TabIndex = 1;
            this.btnGosti.Text = "Pregled gostiju po sobama";
            this.btnGosti.UseVisualStyleBackColor = true;
            this.btnGosti.Click += new System.EventHandler(this.btnGosti_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(55, 60);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(340, 32);
            this.label1.TabIndex = 2;
            this.label1.Text = "Odaberite zeljeni izvjestaj";
            // 
            // frmOdabir
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(497, 504);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnGosti);
            this.Controls.Add(this.btnRecenzije);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmOdabir";
            this.Text = "frmOdabir";
            this.Load += new System.EventHandler(this.frmOdabir_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnRecenzije;
        private System.Windows.Forms.Button btnGosti;
        private System.Windows.Forms.Label label1;
    }
}