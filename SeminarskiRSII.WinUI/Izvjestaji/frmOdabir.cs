using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Izvjestaji
{
    public partial class frmOdabir : Form
    {
        public frmOdabir()
        {
            InitializeComponent();
        }

        private void btnGosti_Click(object sender, EventArgs e)
        {
            frmSobeIzvjestaj frm = new frmSobeIzvjestaj();
            frm.Show();
        }

        private void btnRecenzije_Click(object sender, EventArgs e)
        {
            frmRecenzijeIzvjestaj frm = new frmRecenzijeIzvjestaj();
            frm.Show();
        }

        private void frmOdabir_Load(object sender, EventArgs e)
        {

        }
    }
}
