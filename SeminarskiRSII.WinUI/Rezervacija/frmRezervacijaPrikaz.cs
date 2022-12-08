using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Rezervacija
{
    public partial class frmRezervacijaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Rezervacija");
        public frmRezervacijaPrikaz()
        {
            InitializeComponent();
            dgwRezervacije.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new RezervacijaSearchRequest()
            {
                BrojSobe = int.Parse(txtPretraga.Text)
            };
            var list = await _service.get<List<Model.Models.Rezervacija>>(search);
            dgwRezervacije.DataSource = list;
        }

        private async void frmRezervacijaPrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.Rezervacija>>(null);
            dgwRezervacije.DataSource = list;
        }

        private void dgwRezervacije_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwRezervacije.SelectedRows[0].Cells[0].Value;
            frmRezervacijaDetalji frm = new frmRezervacijaDetalji(int.Parse(id.ToString()));
            frm.ShowDialog();
        }
    }
}
