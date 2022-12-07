using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Izvjestaji
{
    public partial class frmSobeIzvjestaj : Form
    {
        private readonly ApiService _service = new ApiService("Soba");
        public frmSobeIzvjestaj()
        {
            InitializeComponent();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void btnOdaberi_Click(object sender, EventArgs e)
        {
            var tap = cbSobe.SelectedValue.ToString();
            if(int.TryParse(tap, out int id))
            {
                frmSobeDetaljiIzvjestaj frm = new frmSobeDetaljiIzvjestaj(id);
                frm.ShowDialog();
            }
        }

        private async void frmSobeIzvjestaj_Load(object sender, EventArgs e)
        {
            var list = await _service.get<List<Model.Models.Soba>>(null);
            list.Insert(0, new Model.Models.Soba());
            cbSobe.DataSource = list;
            cbSobe.DisplayMember = "BrojSobe";
            cbSobe.ValueMember = "Id";
        }
    }
}
