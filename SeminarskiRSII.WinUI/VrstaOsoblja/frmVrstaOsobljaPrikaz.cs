using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.VrstaOsoblja
{
    public partial class frmVrstaOsobljaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("VrstaOsoblja");

        public frmVrstaOsobljaPrikaz()
        {
            InitializeComponent();
            dgwVrstaOsoblja.AutoGenerateColumns = false;
        }

        private async void frmVrstaOsobljaPrikaz_Load(object sender, EventArgs e)
        {
            var result = await _service.get<List<Model.Models.VrstaOsoblja>>(null);
            dgwVrstaOsoblja.DataSource = result;
        }

        private void dgwVrstaOsoblja_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwVrstaOsoblja.SelectedRows[0].Cells[0].Value;
            frmVrstaOsobljaDetalji frm = new frmVrstaOsobljaDetalji(int.Parse(id.ToString()));
            frm.Show();
        }
    }
}
