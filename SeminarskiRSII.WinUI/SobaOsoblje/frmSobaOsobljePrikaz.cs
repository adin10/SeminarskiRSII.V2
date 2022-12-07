using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.SobaOsoblje
{
    public partial class frmSobaOsobljePrikaz : Form
    {
        private readonly ApiService _service = new ApiService("SobaOsoblje");
        public frmSobaOsobljePrikaz()
        {
            InitializeComponent();
            dgwSobaOsoblje.AutoGenerateColumns = false;
        }

        private async void frmSobaOsobljePrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.SobaOsoblje>>(null);
            dgwSobaOsoblje.DataSource = list;
        }

        private void dgwSobaOsoblje_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwSobaOsoblje.SelectedRows[0].Cells[0].Value;
            frmSobaOsobljeDetalji frm = new frmSobaOsobljeDetalji(int.Parse(id.ToString()));
            frm.Show();
        }
    }
}
