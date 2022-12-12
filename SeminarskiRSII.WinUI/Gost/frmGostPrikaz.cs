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

namespace SeminarskiRSII.WinUI.Gost
{
    public partial class frmGostPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Gost");
        public frmGostPrikaz()
        {
            InitializeComponent();
            dgwGosti.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new GostiSearchRequest()
            {
                ime = txtPretraga.Text,
                prezime = txtPrezime.Text
            };
            var result = await _service.get<List<Model.Models.Gost>>(search);
            dgwGosti.DataSource = result;
        }

        private async void frmGostPrikaz_Load(object sender, EventArgs e)
        {
            await LoadGosti();
        }

        public async Task LoadGosti()
        {
            var lista = await _service.get<List<Model.Models.Gost>>(null);
            dgwGosti.DataSource = lista;
        }

        private async void dgwGosti_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwGosti.SelectedRows[0].Cells[0].Value;
            var gost = await _service.getByID<Model.Models.Gost>(id);
            if(dgwGosti.CurrentCell is DataGridViewButtonCell && gost != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete gosta '{gost.Ime} {gost.Prezime}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadGosti();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(gost.Id);
                    await LoadGosti();
                }
            }
            else
            {
                frmGostDetalji frm = new frmGostDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadGosti();
            }
        }
    }
}
