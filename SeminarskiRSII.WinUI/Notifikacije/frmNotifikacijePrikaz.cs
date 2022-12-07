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

namespace SeminarskiRSII.WinUI.Notifikacije
{
    public partial class frmNotifikacijePrikaz : Form
    {
        private ApiService _notifikacije = new ApiService("Notifikacije");
        private ApiService _novosti = new ApiService("Novosti");
        public frmNotifikacijePrikaz()
        {
            InitializeComponent();
            dgwNotifikacije.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new NotifikacijeSearchRequest()
            {
                Naslov = txtNaslov.Text
            };

            var lista = await _notifikacije.get<List<Model.Models.Notifikacije>>(search);

            dgwNotifikacije.DataSource = lista;
        }

        private async void frmNotifikacijePrikaz_Load(object sender, EventArgs e)
        {
            try
            {
                var lista = await _notifikacije.get<List<Model.Models.Notifikacije>>(null);



                dgwNotifikacije.DataSource = lista;
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message, "Notifikacija", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
