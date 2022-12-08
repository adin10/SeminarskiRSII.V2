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

namespace SeminarskiRSII.WinUI.Recenzija
{
    public partial class frmRecenzijaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Recenzija");
        public frmRecenzijaPrikaz()
        {
            InitializeComponent();
            dgwRecenzija.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            int outpoutValue = 0;
            bool ISnumber = false;
            ISnumber = int.TryParse(txtPretraga.Text, out outpoutValue);
            if (!ISnumber)
            {
                var list = await _service.get<List<Model.Models.Recenzija>>(null);
                MessageBox.Show("Unesite ocjenu koju zelite pretraziti u textBox");

            }
            else
            {
                var search = new RecenzijaSearchRequest()
                {
                    ocjena = int.Parse(txtPretraga.Text)

                };

                var list = await _service.get<List<Model.Models.Recenzija>>(search);
                dgwRecenzija.DataSource = list;
            }
        }

        private async void frmRecenzijaPrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.Recenzija>>(null);
            dgwRecenzija.DataSource = list;
        }

        private void dgwRecenzija_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwRecenzija.SelectedRows[0].Cells[0].Value;
            frmRecenzijaDetalji frm = new frmRecenzijaDetalji(int.Parse(id.ToString()));
            frm.ShowDialog();
        }
    }
}
