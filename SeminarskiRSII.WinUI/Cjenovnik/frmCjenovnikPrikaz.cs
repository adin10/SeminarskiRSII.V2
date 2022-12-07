using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Cjenovnik
{
    public partial class frmCjenovnikPrikaz : Form
    {
        private readonly ApiService _Service = new ApiService("Cjenovnik");
        public frmCjenovnikPrikaz()
        {
            InitializeComponent();
            dgwCjenovnik.AutoGenerateColumns = false;
        }

        private async void frmCjenovnikPrikaz_Load(object sender, EventArgs e)
        {
            var list = await _Service.get<List<Model.Models.Cjenovnik>>(null);
            dgwCjenovnik.DataSource = list;
        }

        private void dgwCjenovnik_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwCjenovnik.SelectedRows[0].Cells[0].Value;
            frmCjenovnikDetalji frm = new frmCjenovnikDetalji(int.Parse(id.ToString()));
            frm.Show();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
