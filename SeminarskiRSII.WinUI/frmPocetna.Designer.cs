
namespace SeminarskiRSII.WinUI
{
    partial class frmPocetna
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
            this.toolTip = new System.Windows.Forms.ToolTip(this.components);
            this.menuStrip = new System.Windows.Forms.MenuStrip();
            this.drzavaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaDrzavaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuDrzavuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cjenovnikToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pregledCijenaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuCijenuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sobaStatusToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pregledStatusaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNoviStatusToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.gradToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaGradovaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNoviGradToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.gostToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaSvihGostijuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovogGostaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sobaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sveSobeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuSobuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.vrstaOsobljaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaPozicijaIZaduzenjaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuVrstuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sobaOsobljeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodjeliSobuOsobljuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.rezervacijeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaRezervacijaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuRezervacijuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.recenzijaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaOcjenaIKomentaraToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajRecenzijuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.osobljeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaUposlenihToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajUposlenikaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.novostiToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaObavijestiToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovuObavijestToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.notifikacijeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listaSvihNotifikacijaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.izvjestajiToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.statusStrip = new System.Windows.Forms.StatusStrip();
            this.menuStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip
            // 
            this.menuStrip.Dock = System.Windows.Forms.DockStyle.Left;
            this.menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.drzavaToolStripMenuItem,
            this.cjenovnikToolStripMenuItem,
            this.sobaStatusToolStripMenuItem,
            this.gradToolStripMenuItem,
            this.gostToolStripMenuItem,
            this.sobaToolStripMenuItem,
            this.vrstaOsobljaToolStripMenuItem,
            this.sobaOsobljeToolStripMenuItem,
            this.rezervacijeToolStripMenuItem,
            this.recenzijaToolStripMenuItem,
            this.osobljeToolStripMenuItem,
            this.novostiToolStripMenuItem,
            this.notifikacijeToolStripMenuItem,
            this.izvjestajiToolStripMenuItem});
            this.menuStrip.LayoutStyle = System.Windows.Forms.ToolStripLayoutStyle.VerticalStackWithOverflow;
            this.menuStrip.Location = new System.Drawing.Point(0, 0);
            this.menuStrip.Name = "menuStrip";
            this.menuStrip.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.menuStrip.Size = new System.Drawing.Size(96, 755);
            this.menuStrip.TabIndex = 4;
            this.menuStrip.Text = "MenuStrip";
            this.menuStrip.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.menuStrip_ItemClicked);
            // 
            // drzavaToolStripMenuItem
            // 
            this.drzavaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaDrzavaToolStripMenuItem,
            this.dodajNovuDrzavuToolStripMenuItem});
            this.drzavaToolStripMenuItem.Name = "drzavaToolStripMenuItem";
            this.drzavaToolStripMenuItem.Size = new System.Drawing.Size(54, 20);
            this.drzavaToolStripMenuItem.Text = "Drzava";
            // 
            // listaDrzavaToolStripMenuItem
            // 
            this.listaDrzavaToolStripMenuItem.Name = "listaDrzavaToolStripMenuItem";
            this.listaDrzavaToolStripMenuItem.Size = new System.Drawing.Size(173, 22);
            this.listaDrzavaToolStripMenuItem.Text = "Lista drzava";
            this.listaDrzavaToolStripMenuItem.Click += new System.EventHandler(this.listaDrzavaToolStripMenuItem_Click);
            // 
            // dodajNovuDrzavuToolStripMenuItem
            // 
            this.dodajNovuDrzavuToolStripMenuItem.Name = "dodajNovuDrzavuToolStripMenuItem";
            this.dodajNovuDrzavuToolStripMenuItem.Size = new System.Drawing.Size(173, 22);
            this.dodajNovuDrzavuToolStripMenuItem.Text = "Dodaj novu drzavu";
            this.dodajNovuDrzavuToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuDrzavuToolStripMenuItem_Click);
            // 
            // cjenovnikToolStripMenuItem
            // 
            this.cjenovnikToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.pregledCijenaToolStripMenuItem,
            this.dodajNovuCijenuToolStripMenuItem});
            this.cjenovnikToolStripMenuItem.Name = "cjenovnikToolStripMenuItem";
            this.cjenovnikToolStripMenuItem.Size = new System.Drawing.Size(72, 20);
            this.cjenovnikToolStripMenuItem.Text = "Cjenovnik";
            // 
            // pregledCijenaToolStripMenuItem
            // 
            this.pregledCijenaToolStripMenuItem.Name = "pregledCijenaToolStripMenuItem";
            this.pregledCijenaToolStripMenuItem.Size = new System.Drawing.Size(170, 22);
            this.pregledCijenaToolStripMenuItem.Text = "Pregled cijena";
            this.pregledCijenaToolStripMenuItem.Click += new System.EventHandler(this.pregledCijenaToolStripMenuItem_Click);
            // 
            // dodajNovuCijenuToolStripMenuItem
            // 
            this.dodajNovuCijenuToolStripMenuItem.Name = "dodajNovuCijenuToolStripMenuItem";
            this.dodajNovuCijenuToolStripMenuItem.Size = new System.Drawing.Size(170, 22);
            this.dodajNovuCijenuToolStripMenuItem.Text = "Dodaj novu cijenu";
            this.dodajNovuCijenuToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuCijenuToolStripMenuItem_Click);
            // 
            // sobaStatusToolStripMenuItem
            // 
            this.sobaStatusToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.pregledStatusaToolStripMenuItem,
            this.dodajNoviStatusToolStripMenuItem});
            this.sobaStatusToolStripMenuItem.Name = "sobaStatusToolStripMenuItem";
            this.sobaStatusToolStripMenuItem.Size = new System.Drawing.Size(82, 20);
            this.sobaStatusToolStripMenuItem.Text = "Soba-Status";
            // 
            // pregledStatusaToolStripMenuItem
            // 
            this.pregledStatusaToolStripMenuItem.Name = "pregledStatusaToolStripMenuItem";
            this.pregledStatusaToolStripMenuItem.Size = new System.Drawing.Size(165, 22);
            this.pregledStatusaToolStripMenuItem.Text = "Pregled statusa";
            this.pregledStatusaToolStripMenuItem.Click += new System.EventHandler(this.pregledStatusaToolStripMenuItem_Click);
            // 
            // dodajNoviStatusToolStripMenuItem
            // 
            this.dodajNoviStatusToolStripMenuItem.Name = "dodajNoviStatusToolStripMenuItem";
            this.dodajNoviStatusToolStripMenuItem.Size = new System.Drawing.Size(165, 22);
            this.dodajNoviStatusToolStripMenuItem.Text = "Dodaj novi status";
            this.dodajNoviStatusToolStripMenuItem.Click += new System.EventHandler(this.dodajNoviStatusToolStripMenuItem_Click);
            // 
            // gradToolStripMenuItem
            // 
            this.gradToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaGradovaToolStripMenuItem,
            this.dodajNoviGradToolStripMenuItem});
            this.gradToolStripMenuItem.Name = "gradToolStripMenuItem";
            this.gradToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.gradToolStripMenuItem.Text = "Grad";
            // 
            // listaGradovaToolStripMenuItem
            // 
            this.listaGradovaToolStripMenuItem.Name = "listaGradovaToolStripMenuItem";
            this.listaGradovaToolStripMenuItem.Size = new System.Drawing.Size(158, 22);
            this.listaGradovaToolStripMenuItem.Text = "Lista gradova";
            this.listaGradovaToolStripMenuItem.Click += new System.EventHandler(this.listaGradovaToolStripMenuItem_Click);
            // 
            // dodajNoviGradToolStripMenuItem
            // 
            this.dodajNoviGradToolStripMenuItem.Name = "dodajNoviGradToolStripMenuItem";
            this.dodajNoviGradToolStripMenuItem.Size = new System.Drawing.Size(158, 22);
            this.dodajNoviGradToolStripMenuItem.Text = "Dodaj novi grad";
            this.dodajNoviGradToolStripMenuItem.Click += new System.EventHandler(this.dodajNoviGradToolStripMenuItem_Click);
            // 
            // gostToolStripMenuItem
            // 
            this.gostToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaSvihGostijuToolStripMenuItem,
            this.dodajNovogGostaToolStripMenuItem});
            this.gostToolStripMenuItem.Name = "gostToolStripMenuItem";
            this.gostToolStripMenuItem.Size = new System.Drawing.Size(43, 20);
            this.gostToolStripMenuItem.Text = "Gost";
            // 
            // listaSvihGostijuToolStripMenuItem
            // 
            this.listaSvihGostijuToolStripMenuItem.Name = "listaSvihGostijuToolStripMenuItem";
            this.listaSvihGostijuToolStripMenuItem.Size = new System.Drawing.Size(174, 22);
            this.listaSvihGostijuToolStripMenuItem.Text = "Lista svih gostiju";
            this.listaSvihGostijuToolStripMenuItem.Click += new System.EventHandler(this.listaSvihGostijuToolStripMenuItem_Click);
            // 
            // dodajNovogGostaToolStripMenuItem
            // 
            this.dodajNovogGostaToolStripMenuItem.Name = "dodajNovogGostaToolStripMenuItem";
            this.dodajNovogGostaToolStripMenuItem.Size = new System.Drawing.Size(174, 22);
            this.dodajNovogGostaToolStripMenuItem.Text = "Dodaj novog gosta";
            this.dodajNovogGostaToolStripMenuItem.Click += new System.EventHandler(this.dodajNovogGostaToolStripMenuItem_Click);
            // 
            // sobaToolStripMenuItem
            // 
            this.sobaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sveSobeToolStripMenuItem,
            this.dodajNovuSobuToolStripMenuItem});
            this.sobaToolStripMenuItem.Name = "sobaToolStripMenuItem";
            this.sobaToolStripMenuItem.Size = new System.Drawing.Size(45, 20);
            this.sobaToolStripMenuItem.Text = "Soba";
            // 
            // sveSobeToolStripMenuItem
            // 
            this.sveSobeToolStripMenuItem.Name = "sveSobeToolStripMenuItem";
            this.sveSobeToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.sveSobeToolStripMenuItem.Text = "Sve sobe";
            this.sveSobeToolStripMenuItem.Click += new System.EventHandler(this.sveSobeToolStripMenuItem_Click);
            // 
            // dodajNovuSobuToolStripMenuItem
            // 
            this.dodajNovuSobuToolStripMenuItem.Name = "dodajNovuSobuToolStripMenuItem";
            this.dodajNovuSobuToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.dodajNovuSobuToolStripMenuItem.Text = "Dodaj novu sobu";
            this.dodajNovuSobuToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuSobuToolStripMenuItem_Click);
            // 
            // vrstaOsobljaToolStripMenuItem
            // 
            this.vrstaOsobljaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaPozicijaIZaduzenjaToolStripMenuItem,
            this.dodajNovuVrstuToolStripMenuItem});
            this.vrstaOsobljaToolStripMenuItem.Name = "vrstaOsobljaToolStripMenuItem";
            this.vrstaOsobljaToolStripMenuItem.Size = new System.Drawing.Size(86, 20);
            this.vrstaOsobljaToolStripMenuItem.Text = "Vrsta osoblja";
            // 
            // listaPozicijaIZaduzenjaToolStripMenuItem
            // 
            this.listaPozicijaIZaduzenjaToolStripMenuItem.Name = "listaPozicijaIZaduzenjaToolStripMenuItem";
            this.listaPozicijaIZaduzenjaToolStripMenuItem.Size = new System.Drawing.Size(202, 22);
            this.listaPozicijaIZaduzenjaToolStripMenuItem.Text = "Lista pozicija i zaduzenja";
            this.listaPozicijaIZaduzenjaToolStripMenuItem.Click += new System.EventHandler(this.listaPozicijaIZaduzenjaToolStripMenuItem_Click);
            // 
            // dodajNovuVrstuToolStripMenuItem
            // 
            this.dodajNovuVrstuToolStripMenuItem.Name = "dodajNovuVrstuToolStripMenuItem";
            this.dodajNovuVrstuToolStripMenuItem.Size = new System.Drawing.Size(202, 22);
            this.dodajNovuVrstuToolStripMenuItem.Text = "Dodaj novu vrstu";
            this.dodajNovuVrstuToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuVrstuToolStripMenuItem_Click);
            // 
            // sobaOsobljeToolStripMenuItem
            // 
            this.sobaOsobljeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem,
            this.dodjeliSobuOsobljuToolStripMenuItem});
            this.sobaOsobljeToolStripMenuItem.Name = "sobaOsobljeToolStripMenuItem";
            this.sobaOsobljeToolStripMenuItem.Size = new System.Drawing.Size(90, 20);
            this.sobaOsobljeToolStripMenuItem.Text = "Soba-Osoblje";
            // 
            // listaOsobljaZaduzenihPoSobamaToolStripMenuItem
            // 
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem.Name = "listaOsobljaZaduzenihPoSobamaToolStripMenuItem";
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem.Size = new System.Drawing.Size(257, 22);
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem.Text = "Lista osoblja zaduzenih po sobama";
            this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem.Click += new System.EventHandler(this.listaOsobljaZaduzenihPoSobamaToolStripMenuItem_Click);
            // 
            // dodjeliSobuOsobljuToolStripMenuItem
            // 
            this.dodjeliSobuOsobljuToolStripMenuItem.Name = "dodjeliSobuOsobljuToolStripMenuItem";
            this.dodjeliSobuOsobljuToolStripMenuItem.Size = new System.Drawing.Size(257, 22);
            this.dodjeliSobuOsobljuToolStripMenuItem.Text = "Dodjeli sobu osoblju";
            this.dodjeliSobuOsobljuToolStripMenuItem.Click += new System.EventHandler(this.dodjeliSobuOsobljuToolStripMenuItem_Click);
            // 
            // rezervacijeToolStripMenuItem
            // 
            this.rezervacijeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaRezervacijaToolStripMenuItem,
            this.dodajNovuRezervacijuToolStripMenuItem});
            this.rezervacijeToolStripMenuItem.Name = "rezervacijeToolStripMenuItem";
            this.rezervacijeToolStripMenuItem.Size = new System.Drawing.Size(77, 20);
            this.rezervacijeToolStripMenuItem.Text = "Rezervacije";
            // 
            // listaRezervacijaToolStripMenuItem
            // 
            this.listaRezervacijaToolStripMenuItem.Name = "listaRezervacijaToolStripMenuItem";
            this.listaRezervacijaToolStripMenuItem.Size = new System.Drawing.Size(194, 22);
            this.listaRezervacijaToolStripMenuItem.Text = "Lista rezervacija";
            this.listaRezervacijaToolStripMenuItem.Click += new System.EventHandler(this.listaRezervacijaToolStripMenuItem_Click);
            // 
            // dodajNovuRezervacijuToolStripMenuItem
            // 
            this.dodajNovuRezervacijuToolStripMenuItem.Name = "dodajNovuRezervacijuToolStripMenuItem";
            this.dodajNovuRezervacijuToolStripMenuItem.Size = new System.Drawing.Size(194, 22);
            this.dodajNovuRezervacijuToolStripMenuItem.Text = "Dodaj novu rezervaciju";
            this.dodajNovuRezervacijuToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuRezervacijuToolStripMenuItem_Click);
            // 
            // recenzijaToolStripMenuItem
            // 
            this.recenzijaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaOcjenaIKomentaraToolStripMenuItem,
            this.dodajRecenzijuToolStripMenuItem});
            this.recenzijaToolStripMenuItem.Name = "recenzijaToolStripMenuItem";
            this.recenzijaToolStripMenuItem.Size = new System.Drawing.Size(68, 20);
            this.recenzijaToolStripMenuItem.Text = "Recenzija";
            // 
            // listaOcjenaIKomentaraToolStripMenuItem
            // 
            this.listaOcjenaIKomentaraToolStripMenuItem.Name = "listaOcjenaIKomentaraToolStripMenuItem";
            this.listaOcjenaIKomentaraToolStripMenuItem.Size = new System.Drawing.Size(202, 22);
            this.listaOcjenaIKomentaraToolStripMenuItem.Text = "Lista ocjena i komentara";
            this.listaOcjenaIKomentaraToolStripMenuItem.Click += new System.EventHandler(this.listaOcjenaIKomentaraToolStripMenuItem_Click);
            // 
            // dodajRecenzijuToolStripMenuItem
            // 
            this.dodajRecenzijuToolStripMenuItem.Name = "dodajRecenzijuToolStripMenuItem";
            this.dodajRecenzijuToolStripMenuItem.Size = new System.Drawing.Size(202, 22);
            this.dodajRecenzijuToolStripMenuItem.Text = "Dodaj recenziju";
            this.dodajRecenzijuToolStripMenuItem.Click += new System.EventHandler(this.dodajRecenzijuToolStripMenuItem_Click);
            // 
            // osobljeToolStripMenuItem
            // 
            this.osobljeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaUposlenihToolStripMenuItem,
            this.dodajUposlenikaToolStripMenuItem});
            this.osobljeToolStripMenuItem.Name = "osobljeToolStripMenuItem";
            this.osobljeToolStripMenuItem.Size = new System.Drawing.Size(59, 20);
            this.osobljeToolStripMenuItem.Text = "Osoblje";
            // 
            // listaUposlenihToolStripMenuItem
            // 
            this.listaUposlenihToolStripMenuItem.Name = "listaUposlenihToolStripMenuItem";
            this.listaUposlenihToolStripMenuItem.Size = new System.Drawing.Size(165, 22);
            this.listaUposlenihToolStripMenuItem.Text = "Lista uposlenih";
            this.listaUposlenihToolStripMenuItem.Click += new System.EventHandler(this.listaUposlenihToolStripMenuItem_Click);
            // 
            // dodajUposlenikaToolStripMenuItem
            // 
            this.dodajUposlenikaToolStripMenuItem.Name = "dodajUposlenikaToolStripMenuItem";
            this.dodajUposlenikaToolStripMenuItem.Size = new System.Drawing.Size(165, 22);
            this.dodajUposlenikaToolStripMenuItem.Text = "Dodaj uposlenika";
            this.dodajUposlenikaToolStripMenuItem.Click += new System.EventHandler(this.dodajUposlenikaToolStripMenuItem_Click);
            // 
            // novostiToolStripMenuItem
            // 
            this.novostiToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaObavijestiToolStripMenuItem,
            this.dodajNovuObavijestToolStripMenuItem});
            this.novostiToolStripMenuItem.Name = "novostiToolStripMenuItem";
            this.novostiToolStripMenuItem.Size = new System.Drawing.Size(60, 20);
            this.novostiToolStripMenuItem.Text = "Novosti";
            // 
            // listaObavijestiToolStripMenuItem
            // 
            this.listaObavijestiToolStripMenuItem.Name = "listaObavijestiToolStripMenuItem";
            this.listaObavijestiToolStripMenuItem.Size = new System.Drawing.Size(185, 22);
            this.listaObavijestiToolStripMenuItem.Text = "Lista obavijesti";
            this.listaObavijestiToolStripMenuItem.Click += new System.EventHandler(this.listaObavijestiToolStripMenuItem_Click);
            // 
            // dodajNovuObavijestToolStripMenuItem
            // 
            this.dodajNovuObavijestToolStripMenuItem.Name = "dodajNovuObavijestToolStripMenuItem";
            this.dodajNovuObavijestToolStripMenuItem.Size = new System.Drawing.Size(185, 22);
            this.dodajNovuObavijestToolStripMenuItem.Text = "Dodaj novu obavijest";
            this.dodajNovuObavijestToolStripMenuItem.Click += new System.EventHandler(this.dodajNovuObavijestToolStripMenuItem_Click);
            // 
            // notifikacijeToolStripMenuItem
            // 
            this.notifikacijeToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.listaSvihNotifikacijaToolStripMenuItem});
            this.notifikacijeToolStripMenuItem.Name = "notifikacijeToolStripMenuItem";
            this.notifikacijeToolStripMenuItem.Size = new System.Drawing.Size(79, 20);
            this.notifikacijeToolStripMenuItem.Text = "Notifikacije";
            // 
            // listaSvihNotifikacijaToolStripMenuItem
            // 
            this.listaSvihNotifikacijaToolStripMenuItem.Name = "listaSvihNotifikacijaToolStripMenuItem";
            this.listaSvihNotifikacijaToolStripMenuItem.Size = new System.Drawing.Size(183, 22);
            this.listaSvihNotifikacijaToolStripMenuItem.Text = "Lista svih notifikacija";
            this.listaSvihNotifikacijaToolStripMenuItem.Click += new System.EventHandler(this.listaSvihNotifikacijaToolStripMenuItem_Click);
            // 
            // izvjestajiToolStripMenuItem
            // 
            this.izvjestajiToolStripMenuItem.Name = "izvjestajiToolStripMenuItem";
            this.izvjestajiToolStripMenuItem.Size = new System.Drawing.Size(63, 20);
            this.izvjestajiToolStripMenuItem.Text = "Izvjestaji";
            this.izvjestajiToolStripMenuItem.Click += new System.EventHandler(this.izvjestajiToolStripMenuItem_Click);
            // 
            // statusStrip
            // 
            this.statusStrip.Location = new System.Drawing.Point(96, 733);
            this.statusStrip.Name = "statusStrip";
            this.statusStrip.Size = new System.Drawing.Size(1194, 22);
            this.statusStrip.TabIndex = 6;
            this.statusStrip.Text = "statusStrip1";
            // 
            // frmPocetna
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1290, 755);
            this.Controls.Add(this.statusStrip);
            this.Controls.Add(this.menuStrip);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip;
            this.Name = "frmPocetna";
            this.Text = "frmPocetna";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmPocetna_Load);
            this.menuStrip.ResumeLayout(false);
            this.menuStrip.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }
        #endregion
        private System.Windows.Forms.ToolTip toolTip;
        private System.Windows.Forms.MenuStrip menuStrip;
        private System.Windows.Forms.ToolStripMenuItem drzavaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaDrzavaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuDrzavuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cjenovnikToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pregledCijenaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuCijenuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sobaStatusToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pregledStatusaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNoviStatusToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem gradToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaGradovaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNoviGradToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem gostToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaSvihGostijuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovogGostaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sobaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sveSobeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuSobuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem vrstaOsobljaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaPozicijaIZaduzenjaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuVrstuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sobaOsobljeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaOsobljaZaduzenihPoSobamaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodjeliSobuOsobljuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem rezervacijeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaRezervacijaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuRezervacijuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem recenzijaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaOcjenaIKomentaraToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajRecenzijuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem osobljeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaUposlenihToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajUposlenikaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem novostiToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaObavijestiToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovuObavijestToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem notifikacijeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem listaSvihNotifikacijaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem izvjestajiToolStripMenuItem;
        private System.Windows.Forms.StatusStrip statusStrip;
    }
}



