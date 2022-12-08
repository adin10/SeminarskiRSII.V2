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

namespace SeminarskiRSII.WinUI.Drzava
{
    public partial class frmDrzavaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Drzava");
        public frmDrzavaPrikaz()
        {
            InitializeComponent();
            dgwDrzave.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new DrzavaSearchRequest()
            {
                naziv = txtPretraga.Text
            };
            var result = await _service.get<List<Model.Models.Drzava>>(search);  // Uzimamo listu drzava sa apija

            dgwDrzave.DataSource = result;       // Dodjeljujemo data grid viewu drzave sa apija
        }

        private async void frmDrzavaPrikaz_Load(object sender, EventArgs e)
        {
            var result = await _service.get<List<Model.Models.Drzava>>(null);
            dgwDrzave.DataSource = result;
        }

        private void dgwDrzave_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwDrzave.SelectedRows[0].Cells[0].Value;  // na koju smo drzavu uradili dupli klik
            frmDodajDrzavu frm = new frmDodajDrzavu(int.Parse(id.ToString()));  // Ako odaberemo neku drzavu otidji u formu za dodavanje novog korisnika
            frm.ShowDialog();
        }
    }
}
