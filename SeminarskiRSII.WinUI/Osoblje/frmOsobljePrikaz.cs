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

namespace SeminarskiRSII.WinUI.Osoblje
{
    public partial class frmOsobljePrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Osoblje");
        public frmOsobljePrikaz()
        {
            InitializeComponent();
            dgwOsoblje.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new OsobljeSearchRequest()
            {
                ime = txtPretraga.Text,
                prezime = txtPrezime.Text
            };
            var list = await _service.get<List<Model.Models.Osoblje>>(search);
            dgwOsoblje.DataSource = list;
        }

        private async void frmOsobljePrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.Osoblje>>(null);
            dgwOsoblje.DataSource = list;
        }

        private void dgwOsoblje_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwOsoblje.SelectedRows[0].Cells[0].Value;
            frmOsobljeDetalji frm = new frmOsobljeDetalji(int.Parse(id.ToString()));
            frm.Show();
        }
    }
}
