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
            await LoadVrstaOsoblja();
        }

        public async Task LoadVrstaOsoblja()
        {
            var result = await _service.get<List<Model.Models.VrstaOsoblja>>(null);
            dgwVrstaOsoblja.DataSource = result;
        }

        private async void dgwVrstaOsoblja_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwVrstaOsoblja.SelectedRows[0].Cells[0].Value;
            var vrstaOsoblja = await _service.getByID<Model.Models.VrstaOsoblja>(id);
            if(dgwVrstaOsoblja.CurrentCell is DataGridViewButtonCell && vrstaOsoblja != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete zaduzenje '{vrstaOsoblja.Pozicija}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadVrstaOsoblja();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(vrstaOsoblja.Id);
                    await LoadVrstaOsoblja();
                }
            }
            else
            {
                frmVrstaOsobljaDetalji frm = new frmVrstaOsobljaDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadVrstaOsoblja();
            }
        }
    }
}
