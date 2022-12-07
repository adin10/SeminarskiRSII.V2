
namespace SeminarskiRSII.WinUI.Cjenovnik
{
    partial class frmCjenovnikDetalji
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
            this.txtCijena = new System.Windows.Forms.TextBox();
            this.txtBrojdana = new System.Windows.Forms.TextBox();
            this.cmbSoba = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(277, 261);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 31);
            this.btnSnimi.TabIndex = 31;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // txtCijena
            // 
            this.txtCijena.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCijena.Location = new System.Drawing.Point(110, 202);
            this.txtCijena.Name = "txtCijena";
            this.txtCijena.Size = new System.Drawing.Size(242, 23);
            this.txtCijena.TabIndex = 30;
            // 
            // txtBrojdana
            // 
            this.txtBrojdana.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBrojdana.Location = new System.Drawing.Point(110, 146);
            this.txtBrojdana.Name = "txtBrojdana";
            this.txtBrojdana.Size = new System.Drawing.Size(242, 23);
            this.txtBrojdana.TabIndex = 29;
            // 
            // cmbSoba
            // 
            this.cmbSoba.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbSoba.FormattingEnabled = true;
            this.cmbSoba.Location = new System.Drawing.Point(110, 91);
            this.cmbSoba.Name = "cmbSoba";
            this.cmbSoba.Size = new System.Drawing.Size(242, 24);
            this.cmbSoba.TabIndex = 28;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(33, 152);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(69, 17);
            this.label4.TabIndex = 27;
            this.label4.Text = "Broj dana";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(33, 208);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 17);
            this.label3.TabIndex = 26;
            this.label3.Text = "Cijena";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(33, 94);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(41, 17);
            this.label2.TabIndex = 25;
            this.label2.Text = "Soba";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(32, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(156, 20);
            this.label1.TabIndex = 24;
            this.label1.Text = "Dodaj cijenu za sobu";
            // 
            // frmCjenovnikDetalji
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(383, 342);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.txtCijena);
            this.Controls.Add(this.txtBrojdana);
            this.Controls.Add(this.cmbSoba);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmCjenovnikDetalji";
            this.Text = "frmCjenovnikDetalji";
            this.Load += new System.EventHandler(this.frmCjenovnikDetalji_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.TextBox txtCijena;
        private System.Windows.Forms.TextBox txtBrojdana;
        private System.Windows.Forms.ComboBox cmbSoba;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}