
namespace SeminarskiRSII.WinUI.Drzava
{
    partial class frmDrzavaPrikaz
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgwDrzave = new System.Windows.Forms.DataGridView();
            this.DrzavaID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Naziv = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwDrzave)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(25, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 20);
            this.label1.TabIndex = 15;
            this.label1.Text = "Pretraga";
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPretraga.Location = new System.Drawing.Point(25, 52);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(306, 23);
            this.txtPretraga.TabIndex = 14;
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikazi.Location = new System.Drawing.Point(344, 44);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(80, 36);
            this.btnPrikazi.TabIndex = 13;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwDrzave);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(13, 98);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(414, 339);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lista drzava";
            // 
            // dgwDrzave
            // 
            this.dgwDrzave.AllowUserToAddRows = false;
            this.dgwDrzave.AllowUserToDeleteRows = false;
            this.dgwDrzave.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwDrzave.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.DrzavaID,
            this.Naziv});
            this.dgwDrzave.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwDrzave.Location = new System.Drawing.Point(3, 20);
            this.dgwDrzave.Name = "dgwDrzave";
            this.dgwDrzave.ReadOnly = true;
            this.dgwDrzave.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwDrzave.Size = new System.Drawing.Size(408, 316);
            this.dgwDrzave.TabIndex = 0;
            this.dgwDrzave.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwDrzave_MouseDoubleClick);
            // 
            // DrzavaID
            // 
            this.DrzavaID.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DrzavaID.DataPropertyName = "Id";
            this.DrzavaID.HeaderText = "DrzavaID";
            this.DrzavaID.Name = "DrzavaID";
            this.DrzavaID.ReadOnly = true;
            this.DrzavaID.Visible = false;
            // 
            // Naziv
            // 
            this.Naziv.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Naziv.DataPropertyName = "Naziv";
            this.Naziv.HeaderText = "Naziv drzave";
            this.Naziv.Name = "Naziv";
            this.Naziv.ReadOnly = true;
            // 
            // frmDrzavaPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(442, 450);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPretraga);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmDrzavaPrikaz";
            this.Text = "frmDrzavaPrikaz";
            this.Load += new System.EventHandler(this.frmDrzavaPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwDrzave)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPretraga;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwDrzave;
        private System.Windows.Forms.DataGridViewTextBoxColumn DrzavaID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Naziv;
    }
}