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

namespace SeminarskiRSII.WinUI.Gost
{
    public partial class frmGostPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Gost");
        public frmGostPrikaz()
        {
            InitializeComponent();
            dgwGosti.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new GostiSearchRequest()   // Ovo sluzi za pretragu gostiju po imenu i prezimenu
            {
                ime = txtPretraga.Text,
                prezime = txtPrezime.Text
            };
            var result = await _service.get<List<Model.Models.Gost>>(search);      // Dovaljamo sve goste sa api servisa                           
            dgwGosti.DataSource = result;                                   // data grid view popunjavamo sa dobavljenom listom
        }

        private async void frmGostPrikaz_Load(object sender, EventArgs e)
        {
            var lista = await _service.get<List<Model.Models.Gost>>(null);
            dgwGosti.DataSource = lista;
        }

        private void dgwGosti_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwGosti.SelectedRows[0].Cells[0].Value;                    // Uzimamo gosta na kojeg smo izvrsili dupli klik
            frmGostDetalji frm = new frmGostDetalji(int.Parse(id.ToString()));   // Otvaramo formu gostDetalji kojoj proslijedjujemo gosta
            frm.Show();
        }
    }
}
