
namespace SeminarskiRSII.WinUI.Novosti
{
    partial class frmNovostiPrikaz
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
            this.dgwNovosti = new System.Windows.Forms.DataGridView();
            this.ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Naslov = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Sadrzaj = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DatumObavijesti = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NapisaoObjavu = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.txtPretraga = new System.Windows.Forms.TextBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwNovosti)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwNovosti);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(1, 99);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(554, 353);
            this.groupBox1.TabIndex = 15;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Pregled svih novosti";
            // 
            // dgwNovosti
            // 
            this.dgwNovosti.AllowUserToAddRows = false;
            this.dgwNovosti.AllowUserToDeleteRows = false;
            this.dgwNovosti.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwNovosti.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ID,
            this.Naslov,
            this.Sadrzaj,
            this.DatumObavijesti,
            this.NapisaoObjavu});
            this.dgwNovosti.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwNovosti.Location = new System.Drawing.Point(3, 22);
            this.dgwNovosti.Name = "dgwNovosti";
            this.dgwNovosti.ReadOnly = true;
            this.dgwNovosti.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwNovosti.Size = new System.Drawing.Size(548, 328);
            this.dgwNovosti.TabIndex = 0;
            this.dgwNovosti.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwNovosti_MouseDoubleClick);
            // 
            // ID
            // 
            this.ID.DataPropertyName = "Id";
            this.ID.HeaderText = "ID";
            this.ID.Name = "ID";
            this.ID.ReadOnly = true;
            this.ID.Visible = false;
            // 
            // Naslov
            // 
            this.Naslov.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Naslov.DataPropertyName = "Naslov";
            this.Naslov.HeaderText = "Naslov";
            this.Naslov.Name = "Naslov";
            this.Naslov.ReadOnly = true;
            // 
            // Sadrzaj
            // 
            this.Sadrzaj.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Sadrzaj.DataPropertyName = "Sadrzaj";
            this.Sadrzaj.HeaderText = "Sadrzaj";
            this.Sadrzaj.Name = "Sadrzaj";
            this.Sadrzaj.ReadOnly = true;
            // 
            // DatumObavijesti
            // 
            this.DatumObavijesti.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DatumObavijesti.DataPropertyName = "DatumObjave";
            this.DatumObavijesti.HeaderText = "Datum obavijesti";
            this.DatumObavijesti.Name = "DatumObavijesti";
            this.DatumObavijesti.ReadOnly = true;
            // 
            // NapisaoObjavu
            // 
            this.NapisaoObjavu.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.NapisaoObjavu.DataPropertyName = "Osoblje";
            this.NapisaoObjavu.HeaderText = "Objavu napisao";
            this.NapisaoObjavu.Name = "NapisaoObjavu";
            this.NapisaoObjavu.ReadOnly = true;
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnPrikazi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPrikazi.Location = new System.Drawing.Point(475, 38);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(80, 40);
            this.btnPrikazi.TabIndex = 14;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = false;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 20);
            this.label1.TabIndex = 13;
            this.label1.Text = "Pretraga";
            // 
            // txtPretraga
            // 
            this.txtPretraga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPretraga.Location = new System.Drawing.Point(12, 48);
            this.txtPretraga.Name = "txtPretraga";
            this.txtPretraga.Size = new System.Drawing.Size(437, 23);
            this.txtPretraga.TabIndex = 12;
            // 
            // frmNovostiPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(568, 450);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPretraga);
            this.Name = "frmNovostiPrikaz";
            this.Text = "frmNovostiPrikaz";
            this.Load += new System.EventHandler(this.frmNovostiPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwNovosti)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwNovosti;
        private System.Windows.Forms.DataGridViewTextBoxColumn ID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Naslov;
        private System.Windows.Forms.DataGridViewTextBoxColumn Sadrzaj;
        private System.Windows.Forms.DataGridViewTextBoxColumn DatumObavijesti;
        private System.Windows.Forms.DataGridViewTextBoxColumn NapisaoObjavu;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPretraga;
    }
}