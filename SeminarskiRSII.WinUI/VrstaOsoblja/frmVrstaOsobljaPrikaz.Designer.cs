
namespace SeminarskiRSII.WinUI.VrstaOsoblja
{
    partial class frmVrstaOsobljaPrikaz
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
            this.dgwVrstaOsoblja = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Pozicija = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Zaduzenja = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwVrstaOsoblja)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwVrstaOsoblja);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.groupBox1.Location = new System.Drawing.Point(20, 23);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.groupBox1.Size = new System.Drawing.Size(750, 640);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Vrste poslova";
            // 
            // dgwVrstaOsoblja
            // 
            this.dgwVrstaOsoblja.AllowUserToAddRows = false;
            this.dgwVrstaOsoblja.AllowUserToDeleteRows = false;
            this.dgwVrstaOsoblja.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwVrstaOsoblja.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Pozicija,
            this.Zaduzenja});
            this.dgwVrstaOsoblja.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwVrstaOsoblja.Location = new System.Drawing.Point(5, 31);
            this.dgwVrstaOsoblja.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.dgwVrstaOsoblja.Name = "dgwVrstaOsoblja";
            this.dgwVrstaOsoblja.ReadOnly = true;
            this.dgwVrstaOsoblja.RowHeadersWidth = 62;
            this.dgwVrstaOsoblja.RowTemplate.Height = 45;
            this.dgwVrstaOsoblja.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwVrstaOsoblja.Size = new System.Drawing.Size(740, 603);
            this.dgwVrstaOsoblja.TabIndex = 0;
            this.dgwVrstaOsoblja.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwVrstaOsoblja_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.MinimumWidth = 8;
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            this.Id.Width = 150;
            // 
            // Pozicija
            // 
            this.Pozicija.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Pozicija.DataPropertyName = "Pozicija";
            this.Pozicija.HeaderText = "Pozicija";
            this.Pozicija.MinimumWidth = 8;
            this.Pozicija.Name = "Pozicija";
            this.Pozicija.ReadOnly = true;
            // 
            // Zaduzenja
            // 
            this.Zaduzenja.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Zaduzenja.DataPropertyName = "Zaduzenja";
            this.Zaduzenja.HeaderText = "Zaduzenja";
            this.Zaduzenja.MinimumWidth = 8;
            this.Zaduzenja.Name = "Zaduzenja";
            this.Zaduzenja.ReadOnly = true;
            // 
            // frmVrstaOsobljaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(792, 677);
            this.Controls.Add(this.groupBox1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmVrstaOsobljaPrikaz";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmVrstaOsobljaPrikaz";
            this.Load += new System.EventHandler(this.frmVrstaOsobljaPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwVrstaOsoblja)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwVrstaOsoblja;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Pozicija;
        private System.Windows.Forms.DataGridViewTextBoxColumn Zaduzenja;
    }
}