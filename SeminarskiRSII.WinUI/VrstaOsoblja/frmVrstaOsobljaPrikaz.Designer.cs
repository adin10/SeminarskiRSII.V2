
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
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(450, 333);
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
            this.dgwVrstaOsoblja.Location = new System.Drawing.Point(3, 20);
            this.dgwVrstaOsoblja.Name = "dgwVrstaOsoblja";
            this.dgwVrstaOsoblja.ReadOnly = true;
            this.dgwVrstaOsoblja.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwVrstaOsoblja.Size = new System.Drawing.Size(444, 310);
            this.dgwVrstaOsoblja.TabIndex = 0;
            this.dgwVrstaOsoblja.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwVrstaOsoblja_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            // 
            // Pozicija
            // 
            this.Pozicija.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Pozicija.DataPropertyName = "Pozicija";
            this.Pozicija.HeaderText = "Pozicija";
            this.Pozicija.Name = "Pozicija";
            this.Pozicija.ReadOnly = true;
            // 
            // Zaduzenja
            // 
            this.Zaduzenja.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Zaduzenja.DataPropertyName = "Zaduzenja";
            this.Zaduzenja.HeaderText = "Zaduzenja";
            this.Zaduzenja.Name = "Zaduzenja";
            this.Zaduzenja.ReadOnly = true;
            // 
            // frmVrstaOsobljaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(475, 352);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmVrstaOsobljaPrikaz";
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