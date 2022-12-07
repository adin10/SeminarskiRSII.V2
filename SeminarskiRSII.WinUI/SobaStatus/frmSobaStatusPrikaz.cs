using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.SobaStatus
{
    public partial class frmSobaStatusPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("SobaStatus");
        public frmSobaStatusPrikaz()
        {
            InitializeComponent();
            dgwSobaStatus.AutoGenerateColumns = false;
        }

        private async void frmSobaStatusPrikaz_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.SobaStatus>>(null);
            dgwSobaStatus.DataSource = list;
        }

        private void dgwSobaStatus_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwSobaStatus.SelectedRows[0].Cells[0].Value;
            frmSobaStatusDetalji frm = new frmSobaStatusDetalji(int.Parse(id.ToString()));
            frm.Show();
        }
    }
}
