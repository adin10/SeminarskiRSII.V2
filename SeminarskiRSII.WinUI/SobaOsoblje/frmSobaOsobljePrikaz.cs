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
            await loadSobaOsoblje();
        }

        public async Task loadSobaOsoblje()
        {
            var list = await _service.get<List<Model.Models.SobaOsoblje>>(null);
            dgwSobaOsoblje.DataSource = list;
        }

        private async void dgwSobaOsoblje_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwSobaOsoblje.SelectedRows[0].Cells[0].Value;
            var sobaOsoblje = await _service.getByID<Model.Models.SobaOsoblje>(id);
            if(dgwSobaOsoblje.CurrentCell is DataGridViewButtonCell && sobaOsoblje != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite izbrisati uposlenikovo zaduzenje '{sobaOsoblje.Osoblje.Ime} {sobaOsoblje.Osoblje.Prezime}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await loadSobaOsoblje();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(sobaOsoblje.Id);
                    await loadSobaOsoblje();
                }
            }
            else
            {
                frmSobaOsobljeDetalji frm = new frmSobaOsobljeDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await loadSobaOsoblje();
            }
        }
    }
}
