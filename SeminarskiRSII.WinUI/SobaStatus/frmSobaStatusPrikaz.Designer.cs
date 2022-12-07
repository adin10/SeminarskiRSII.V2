
namespace SeminarskiRSII.WinUI.SobaStatus
{
    partial class frmSobaStatusPrikaz
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
            this.dgwSobaStatus = new System.Windows.Forms.DataGridView();
            this.ID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Status = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Opis = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaStatus)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgwSobaStatus);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(502, 413);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Status sobe";
            // 
            // dgwSobaStatus
            // 
            this.dgwSobaStatus.AllowUserToAddRows = false;
            this.dgwSobaStatus.AllowUserToDeleteRows = false;
            this.dgwSobaStatus.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgwSobaStatus.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ID,
            this.Status,
            this.Opis});
            this.dgwSobaStatus.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgwSobaStatus.Location = new System.Drawing.Point(3, 22);
            this.dgwSobaStatus.Name = "dgwSobaStatus";
            this.dgwSobaStatus.ReadOnly = true;
            this.dgwSobaStatus.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgwSobaStatus.Size = new System.Drawing.Size(496, 388);
            this.dgwSobaStatus.TabIndex = 0;
            this.dgwSobaStatus.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.dgwSobaStatus_MouseDoubleClick);
            // 
            // ID
            // 
            this.ID.DataPropertyName = "Id";
            this.ID.HeaderText = "ID";
            this.ID.Name = "ID";
            this.ID.ReadOnly = true;
            this.ID.Visible = false;
            // 
            // Status
            // 
            this.Status.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Status.DataPropertyName = "Status";
            this.Status.HeaderText = "Status";
            this.Status.Name = "Status";
            this.Status.ReadOnly = true;
            // 
            // Opis
            // 
            this.Opis.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Opis.DataPropertyName = "Opis";
            this.Opis.HeaderText = "Opis";
            this.Opis.Name = "Opis";
            this.Opis.ReadOnly = true;
            // 
            // frmSobaStatusPrikaz
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(528, 428);
            this.Controls.Add(this.groupBox1);
            this.Name = "frmSobaStatusPrikaz";
            this.Text = "frmSobaStatusPrikaz";
            this.Load += new System.EventHandler(this.frmSobaStatusPrikaz_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgwSobaStatus)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgwSobaStatus;
        private System.Windows.Forms.DataGridViewTextBoxColumn ID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Status;
        private System.Windows.Forms.DataGridViewTextBoxColumn Opis;
    }
}