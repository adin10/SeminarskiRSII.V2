
namespace SeminarskiRSII.WinUI.Soba
{
    partial class frmSobaDodaj
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
            this.components = new System.ComponentModel.Container();
            this.btnSnimi = new System.Windows.Forms.Button();
            this.pbSoba = new System.Windows.Forms.PictureBox();
            this.btnUcitajSobu = new System.Windows.Forms.Button();
            this.cmbStatusID = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtInformacije = new System.Windows.Forms.TextBox();
            this.txtBrojSprata = new System.Windows.Forms.TextBox();
            this.txtBrojSobe = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.txtPicturePath = new System.Windows.Forms.TextBox();
            this.txtPictureName = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.pbSoba)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
            this.SuspendLayout();
            // 
            // btnSnimi
            // 
            this.btnSnimi.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSnimi.Location = new System.Drawing.Point(311, 446);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(75, 35);
            this.btnSnimi.TabIndex = 48;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // pbSoba
            // 
            this.pbSoba.Location = new System.Drawing.Point(12, 351);
            this.pbSoba.Name = "pbSoba";
            this.pbSoba.Size = new System.Drawing.Size(245, 130);
            this.pbSoba.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbSoba.TabIndex = 47;
            this.pbSoba.TabStop = false;
            this.pbSoba.Click += new System.EventHandler(this.pbSoba_Click);
            this.pbSoba.Validating += new System.ComponentModel.CancelEventHandler(this.pbSoba_Validating);
            // 
            // btnUcitajSobu
            // 
            this.btnUcitajSobu.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUcitajSobu.Location = new System.Drawing.Point(282, 351);
            this.btnUcitajSobu.Name = "btnUcitajSobu";
            this.btnUcitajSobu.Size = new System.Drawing.Size(104, 49);
            this.btnUcitajSobu.TabIndex = 46;
            this.btnUcitajSobu.Text = "Ucitaj sobu";
            this.btnUcitajSobu.UseVisualStyleBackColor = true;
            this.btnUcitajSobu.Click += new System.EventHandler(this.btnUcitajSobu_Click);
            // 
            // cmbStatusID
            // 
            this.cmbStatusID.FormattingEnabled = true;
            this.cmbStatusID.Location = new System.Drawing.Point(116, 217);
            this.cmbStatusID.Name = "cmbStatusID";
            this.cmbStatusID.Size = new System.Drawing.Size(270, 21);
            this.cmbStatusID.TabIndex = 45;
            this.cmbStatusID.Validating += new System.ComponentModel.CancelEventHandler(this.cmbStatusID_Validating);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(28, 220);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(48, 17);
            this.label5.TabIndex = 44;
            this.label5.Text = "Status";
            // 
            // txtInformacije
            // 
            this.txtInformacije.Location = new System.Drawing.Point(116, 170);
            this.txtInformacije.Name = "txtInformacije";
            this.txtInformacije.Size = new System.Drawing.Size(270, 20);
            this.txtInformacije.TabIndex = 43;
            this.txtInformacije.Validating += new System.ComponentModel.CancelEventHandler(this.txtInformacije_Validating);
            // 
            // txtBrojSprata
            // 
            this.txtBrojSprata.Location = new System.Drawing.Point(116, 123);
            this.txtBrojSprata.Name = "txtBrojSprata";
            this.txtBrojSprata.Size = new System.Drawing.Size(270, 20);
            this.txtBrojSprata.TabIndex = 42;
            this.txtBrojSprata.Validating += new System.ComponentModel.CancelEventHandler(this.txtBrojSprata_Validating);
            // 
            // txtBrojSobe
            // 
            this.txtBrojSobe.Location = new System.Drawing.Point(116, 71);
            this.txtBrojSobe.Name = "txtBrojSobe";
            this.txtBrojSobe.Size = new System.Drawing.Size(270, 20);
            this.txtBrojSobe.TabIndex = 41;
            this.txtBrojSobe.Validating += new System.ComponentModel.CancelEventHandler(this.txtBrojSobe_Validating);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(28, 24);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(90, 20);
            this.label4.TabIndex = 40;
            this.label4.Text = "Dodaj sobu";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(28, 173);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(76, 17);
            this.label3.TabIndex = 39;
            this.label3.Text = "Informacije";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(28, 126);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 17);
            this.label2.TabIndex = 38;
            this.label2.Text = "Broj sprata";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(28, 71);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(68, 17);
            this.label1.TabIndex = 37;
            this.label1.Text = "Broj sobe";
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog1";
            // 
            // txtPicturePath
            // 
            this.txtPicturePath.Location = new System.Drawing.Point(117, 309);
            this.txtPicturePath.Name = "txtPicturePath";
            this.txtPicturePath.Size = new System.Drawing.Size(270, 20);
            this.txtPicturePath.TabIndex = 52;
            // 
            // txtPictureName
            // 
            this.txtPictureName.Location = new System.Drawing.Point(117, 262);
            this.txtPictureName.Name = "txtPictureName";
            this.txtPictureName.Size = new System.Drawing.Size(270, 20);
            this.txtPictureName.TabIndex = 51;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(20, 312);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(84, 17);
            this.label6.TabIndex = 50;
            this.label6.Text = "Picture path";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(20, 263);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(91, 17);
            this.label7.TabIndex = 49;
            this.label7.Text = "Picture name";
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // frmSobaDodaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(409, 527);
            this.Controls.Add(this.txtPicturePath);
            this.Controls.Add(this.txtPictureName);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.btnSnimi);
            this.Controls.Add(this.pbSoba);
            this.Controls.Add(this.btnUcitajSobu);
            this.Controls.Add(this.cmbStatusID);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtInformacije);
            this.Controls.Add(this.txtBrojSprata);
            this.Controls.Add(this.txtBrojSobe);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmSobaDodaj";
            this.Text = "frmSobaDodaj";
            this.Load += new System.EventHandler(this.frmSobaDodaj_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pbSoba)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnSnimi;
        private System.Windows.Forms.PictureBox pbSoba;
        private System.Windows.Forms.Button btnUcitajSobu;
        private System.Windows.Forms.ComboBox cmbStatusID;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtInformacije;
        private System.Windows.Forms.TextBox txtBrojSprata;
        private System.Windows.Forms.TextBox txtBrojSobe;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.TextBox txtPicturePath;
        private System.Windows.Forms.TextBox txtPictureName;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ErrorProvider errorProvider;
    }
}