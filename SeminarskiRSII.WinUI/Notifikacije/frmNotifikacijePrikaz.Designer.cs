
namespace SeminarskiRSII.WinUI.Notifikacije
{
    partial class frmNotifikacijePrikaz
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
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.txtNaslov = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwNotifikacije = new System.Windows.Forms.DataGridView();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwNotifikacije)).BeginInit();
            this.SuspendLayout();
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnPrikazi.Location = new System.Drawing.Point(803, 13);
            this.btnPrikazi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(140, 65);
            this.btnPrikazi.TabIndex = 8;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // txtNaslov
            // 
            this.txtNaslov.Location = new System.Drawing.Point(22, 23);
            this.txtNaslov.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtNaslov.Name = "txtNaslov";
            this.txtNaslov.Size = new System.Drawing.Size(717, 31);
            this.txtNaslov.TabIndex = 7;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwNotifikacije);
            this.groupBox1.Location = new System.Drawing.Point(17, 90);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(932, 752);
            this.groupBox1.TabIndex = 6;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Notifikacije";
            // 
            // dgwNotifikacije
            // 
            this.dgwNotifikacije.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwNotifikacije.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwNotifikacije.Location = new System.Drawing.Point(5, 30);
            this.dgwNotifikacije.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwNotifikacije.Name = "dgwNotifikacije";
            this.dgwNotifikacije.RowHeadersWidth = 62;
            this.dgwNotifikacije.Size = new System.Drawing.Size(922, 716);
            this.dgwNotifikacije.TabIndex = 0;
            // 
            // frmNotifikacijePrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(972, 865);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.txtNaslov);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmNotifikacijePrikaz";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmNotifikacijePrikaz";
            this.Load += new System.EventHandler(this.frmNotifikacijePrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwNotifikacije)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.TextBox txtNaslov;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwNotifikacije;
    }
}