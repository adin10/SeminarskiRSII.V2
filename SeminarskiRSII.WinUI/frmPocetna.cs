using SeminarskiRSII.WinUI.Cjenovnik;
using SeminarskiRSII.WinUI.Drzava;
using SeminarskiRSII.WinUI.Gost;
using SeminarskiRSII.WinUI.Grad;
using SeminarskiRSII.WinUI.Izvjestaji;
using SeminarskiRSII.WinUI.Notifikacije;
using SeminarskiRSII.WinUI.Novosti;
using SeminarskiRSII.WinUI.Osoblje;
using SeminarskiRSII.WinUI.Recenzija;
using SeminarskiRSII.WinUI.Rezervacija;
using SeminarskiRSII.WinUI.Soba;
using SeminarskiRSII.WinUI.SobaOsoblje;
using SeminarskiRSII.WinUI.SobaStatus;
using SeminarskiRSII.WinUI.VrstaOsoblja;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI
{
    public partial class frmPocetna : Form
    {
        private int childFormNumber = 0;

        public frmPocetna()
        {
            InitializeComponent();
        }

        private void ShowNewForm(object sender, EventArgs e)
        {
            Form childForm = new Form();
            childForm.MdiParent = this;
            childForm.Text = "Window " + childFormNumber++;
            childForm.Show();
        }

        private void OpenFile(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
            openFileDialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*";
            if (openFileDialog.ShowDialog(this) == DialogResult.OK)
            {
                string FileName = openFileDialog.FileName;
            }
        }

        private void SaveAsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Personal);
            saveFileDialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*";
            if (saveFileDialog.ShowDialog(this) == DialogResult.OK)
            {
                string FileName = saveFileDialog.FileName;
            }
        }

        private void ExitToolsStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void CutToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void CopyToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void PasteToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void ToolBarToolStripMenuItem_Click(object sender, EventArgs e)
        {
          
        }

        private void StatusBarToolStripMenuItem_Click(object sender, EventArgs e)
        {
          
        }

        private void CascadeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LayoutMdi(MdiLayout.Cascade);
        }

        private void TileVerticalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LayoutMdi(MdiLayout.TileVertical);
        }

        private void TileHorizontalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LayoutMdi(MdiLayout.TileHorizontal);
        }

        private void ArrangeIconsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LayoutMdi(MdiLayout.ArrangeIcons);
        }

        private void CloseAllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            foreach (Form childForm in MdiChildren)
            {
                childForm.Close();
            }
        }

        private void toolStripStatusLabel1_Click(object sender, EventArgs e)
        {

        }

        private void frmPocetna_Load(object sender, EventArgs e)
        {

        }

        private void listaDrzavaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDrzavaPrikaz frm = new frmDrzavaPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuDrzavuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDodajDrzavu frm = new frmDodajDrzavu();
            frm.ShowDialog();
        }

        private void pregledCijenaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmCjenovnikPrikaz frm = new frmCjenovnikPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuCijenuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmCjenovnikDetalji frm = new frmCjenovnikDetalji();
            frm.ShowDialog();
        }

        private void pregledStatusaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaStatusPrikaz frm = new frmSobaStatusPrikaz();
            frm.ShowDialog();
        }

        private void dodajNoviStatusToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaStatusDetalji frm = new frmSobaStatusDetalji();
            frm.ShowDialog();
        }

        private void listaGradovaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmGradPrikaz frm = new frmGradPrikaz();
            frm.ShowDialog();
        }

        private void dodajNoviGradToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmGradDetalji frm = new frmGradDetalji();
            frm.ShowDialog();
        }

        private void listaSvihGostijuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmGostPrikaz frm = new frmGostPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovogGostaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmGostDetalji frm = new frmGostDetalji();
            frm.ShowDialog();
        }

        private void sveSobeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaPrikaz frm = new frmSobaPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuSobuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaDodaj frm = new frmSobaDodaj();
            frm.ShowDialog();
        }

        private void listaPozicijaIZaduzenjaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmVrstaOsobljaPrikaz frm = new frmVrstaOsobljaPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuVrstuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmVrstaOsobljaDetalji frm = new frmVrstaOsobljaDetalji();
            frm.ShowDialog();
        }

        private void listaOsobljaZaduzenihPoSobamaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaOsobljePrikaz frm = new frmSobaOsobljePrikaz();
            frm.ShowDialog();
        }

        private void dodjeliSobuOsobljuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSobaOsobljeDetalji frm = new frmSobaOsobljeDetalji();
            frm.ShowDialog();
        }

        private void listaRezervacijaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRezervacijaPrikaz frm = new frmRezervacijaPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuRezervacijuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRezervacijaDetalji frm = new frmRezervacijaDetalji();
            frm.ShowDialog();
        }

        private void listaOcjenaIKomentaraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRecenzijaPrikaz frm = new frmRecenzijaPrikaz();
            frm.ShowDialog();
        }

        private void dodajRecenzijuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRecenzijaDetalji frm = new frmRecenzijaDetalji();
            frm.ShowDialog();
        }

        private void listaUposlenihToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmOsobljePrikaz frm = new frmOsobljePrikaz();
            frm.ShowDialog();
        }

        private void dodajUposlenikaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmOsobljeDetalji frm = new frmOsobljeDetalji();
            frm.ShowDialog();
        }

        private void listaObavijestiToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmNovostiPrikaz frm = new frmNovostiPrikaz();
            frm.ShowDialog();
        }

        private void dodajNovuObavijestToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmNovostiDodaj frm = new frmNovostiDodaj();
            frm.ShowDialog();
        }

        private void listaSvihNotifikacijaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmNotifikacijePrikaz frm = new frmNotifikacijePrikaz();
            frm.ShowDialog();
        }

        private void menuStrip_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void izvjestajiToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmOdabir frm = new frmOdabir();
            frm.ShowDialog();
        }
    }
}
