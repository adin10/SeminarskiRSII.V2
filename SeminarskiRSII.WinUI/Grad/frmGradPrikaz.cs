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

namespace SeminarskiRSII.WinUI.Grad
{
    public partial class frmGradPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Grad");
        public frmGradPrikaz()
        {
            InitializeComponent();
            dgwGradovi.AutoGenerateColumns = false;
        }

        private async void btnPrikaz_Click(object sender, EventArgs e)
        {
            var search = new GradSearchRequest()
            {
                NazivGrada = txtpretraga.Text
            };
            var list = await _service.get<List<Model.Models.Grad>>(search);
            dgwGradovi.DataSource = list;
        }

        private async void frmGradPrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.Grad>>(null);
            dgwGradovi.DataSource = list;
        }

        private void dgwGradovi_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwGradovi.SelectedRows[0].Cells[0].Value;
            frmGradDetalji frm = new frmGradDetalji(int.Parse(id.ToString()));
            frm.ShowDialog();
        }
    }
}
