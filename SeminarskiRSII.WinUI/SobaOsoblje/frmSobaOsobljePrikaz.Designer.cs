
namespace SeminarskiRSII.WinUI.SobaOsoblje
{
    partial class frmSobaOsobljePrikaz
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
            this.dgwSobaOsoblje = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Soba = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Osoblje = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaOsoblje)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwSobaOsoblje);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 22);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(521, 401);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Upsoslenici zaduzeni za sobu";
            // 
            // dgwSobaOsoblje
            // 
            this.dgwSobaOsoblje.AllowUserToAddRows = false;
            this.dgwSobaOsoblje.AllowUserToDeleteRows = false;
            this.dgwSobaOsoblje.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwSobaOsoblje.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Soba,
            this.Osoblje});
            this.dgwSobaOsoblje.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwSobaOsoblje.Location = new System.Drawing.Point(3, 22);
            this.dgwSobaOsoblje.Name = "dgwSobaOsoblje";
            this.dgwSobaOsoblje.ReadOnly = true;
            this.dgwSobaOsoblje.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwSobaOsoblje.Size = new System.Drawing.Size(515, 376);
            this.dgwSobaOsoblje.TabIndex = 0;
            this.dgwSobaOsoblje.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwSobaOsoblje_MouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.ReadOnly = true;
            this.Id.Visible = false;
            // 
            // Soba
            // 
            this.Soba.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Soba.DataPropertyName = "Soba";
            this.Soba.HeaderText = "Soba";
            this.Soba.Name = "Soba";
            this.Soba.ReadOnly = true;
            // 
            // Osoblje
            // 
            this.Osoblje.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Osoblje.DataPropertyName = "Osoblje";
            this.Osoblje.HeaderText = "Osoblje";
            this.Osoblje.Name = "Osoblje";
            this.Osoblje.ReadOnly = true;
            // 
            // frmSobaOsobljePrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(540, 450);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmSobaOsobljePrikaz";
            this.Text = "frmSobaOsobljePrikaz";
            this.Load += new System.EventHandler(this.frmSobaOsobljePrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaOsoblje)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwSobaOsoblje;
        private System.Windows.Forms.DataGridViewTextBoxColumn Id;
        private System.Windows.Forms.DataGridViewTextBoxColumn Soba;
        private System.Windows.Forms.DataGridViewTextBoxColumn Osoblje;
    }
}