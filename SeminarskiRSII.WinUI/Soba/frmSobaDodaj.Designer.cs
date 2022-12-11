
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
            this.labelSobaName = new System.Windows.Forms.Label();
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
            this.btnSnimi.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnSnimi.Location = new System.Drawing.Point(518, 858);
            this.btnSnimi.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnSnimi.Name = "btnSnimi";
            this.btnSnimi.Size = new System.Drawing.Size(125, 67);
            this.btnSnimi.TabIndex = 48;
            this.btnSnimi.Text = "Snimi";
            this.btnSnimi.UseVisualStyleBackColor = false;
            this.btnSnimi.Click += new System.EventHandler(this.btnSnimi_Click);
            // 
            // pbSoba
            // 
            this.pbSoba.Location = new System.Drawing.Point(20, 675);
            this.pbSoba.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.pbSoba.Name = "pbSoba";
            this.pbSoba.Size = new System.Drawing.Size(408, 250);
            this.pbSoba.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbSoba.TabIndex = 47;
            this.pbSoba.TabStop = false;
            this.pbSoba.Validating += new System.ComponentModel.CancelEventHandler(this.pbSoba_Validating);
            // 
            // btnUcitajSobu
            // 
            this.btnUcitajSobu.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.btnUcitajSobu.Location = new System.Drawing.Point(470, 675);
            this.btnUcitajSobu.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.btnUcitajSobu.Name = "btnUcitajSobu";
            this.btnUcitajSobu.Size = new System.Drawing.Size(173, 94);
            this.btnUcitajSobu.TabIndex = 46;
            this.btnUcitajSobu.Text = "Ucitaj sobu";
            this.btnUcitajSobu.UseVisualStyleBackColor = true;
            this.btnUcitajSobu.Click += new System.EventHandler(this.btnUcitajSobu_Click);
            // 
            // cmbStatusID
            // 
            this.cmbStatusID.FormattingEnabled = true;
            this.cmbStatusID.Location = new System.Drawing.Point(193, 417);
            this.cmbStatusID.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.cmbStatusID.Name = "cmbStatusID";
            this.cmbStatusID.Size = new System.Drawing.Size(447, 33);
            this.cmbStatusID.TabIndex = 45;
            this.cmbStatusID.Validating += new System.ComponentModel.CancelEventHandler(this.cmbStatusID_Validating);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label5.Location = new System.Drawing.Point(47, 423);
            this.label5.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(68, 25);
            this.label5.TabIndex = 44;
            this.label5.Text = "Status";
            // 
            // txtInformacije
            // 
            this.txtInformacije.Location = new System.Drawing.Point(193, 327);
            this.txtInformacije.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtInformacije.Name = "txtInformacije";
            this.txtInformacije.Size = new System.Drawing.Size(447, 31);
            this.txtInformacije.TabIndex = 43;
            this.txtInformacije.Validating += new System.ComponentModel.CancelEventHandler(this.txtInformacije_Validating);
            // 
            // txtBrojSprata
            // 
            this.txtBrojSprata.Location = new System.Drawing.Point(193, 237);
            this.txtBrojSprata.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtBrojSprata.Name = "txtBrojSprata";
            this.txtBrojSprata.Size = new System.Drawing.Size(447, 31);
            this.txtBrojSprata.TabIndex = 42;
            this.txtBrojSprata.Validating += new System.ComponentModel.CancelEventHandler(this.txtBrojSprata_Validating);
            // 
            // txtBrojSobe
            // 
            this.txtBrojSobe.Location = new System.Drawing.Point(193, 137);
            this.txtBrojSobe.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtBrojSobe.Name = "txtBrojSobe";
            this.txtBrojSobe.Size = new System.Drawing.Size(447, 31);
            this.txtBrojSobe.TabIndex = 41;
            this.txtBrojSobe.Validating += new System.ComponentModel.CancelEventHandler(this.txtBrojSobe_Validating);
            // 
            // labelSobaName
            // 
            this.labelSobaName.AutoSize = true;
            this.labelSobaName.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.labelSobaName.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.labelSobaName.Location = new System.Drawing.Point(47, 46);
            this.labelSobaName.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.labelSobaName.Name = "labelSobaName";
            this.labelSobaName.Size = new System.Drawing.Size(136, 29);
            this.labelSobaName.TabIndex = 40;
            this.labelSobaName.Text = "Dodaj sobu";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label3.Location = new System.Drawing.Point(47, 333);
            this.label3.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(106, 25);
            this.label3.TabIndex = 39;
            this.label3.Text = "Informacije";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label2.Location = new System.Drawing.Point(47, 242);
            this.label2.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(105, 25);
            this.label2.TabIndex = 38;
            this.label2.Text = "Broj sprata";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(47, 137);
            this.label1.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(94, 25);
            this.label1.TabIndex = 37;
            this.label1.Text = "Broj sobe";
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog1";
            // 
            // txtPicturePath
            // 
            this.txtPicturePath.Location = new System.Drawing.Point(195, 594);
            this.txtPicturePath.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtPicturePath.Name = "txtPicturePath";
            this.txtPicturePath.Size = new System.Drawing.Size(447, 31);
            this.txtPicturePath.TabIndex = 52;
            // 
            // txtPictureName
            // 
            this.txtPictureName.Location = new System.Drawing.Point(195, 504);
            this.txtPictureName.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.txtPictureName.Name = "txtPictureName";
            this.txtPictureName.Size = new System.Drawing.Size(447, 31);
            this.txtPictureName.TabIndex = 51;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label6.Location = new System.Drawing.Point(33, 600);
            this.label6.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(115, 25);
            this.label6.TabIndex = 50;
            this.label6.Text = "Picture path";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label7.Location = new System.Drawing.Point(33, 506);
            this.label7.Margin = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(126, 25);
            this.label7.TabIndex = 49;
            this.label7.Text = "Picture name";
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // frmSobaDodaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(682, 1013);
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
            this.Controls.Add(this.labelSobaName);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(5, 6, 5, 6);
            this.Name = "frmSobaDodaj";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
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
        private System.Windows.Forms.Label labelSobaName;
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