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

namespace SeminarskiRSII.WinUI.Novosti
{
    public partial class frmNovostiPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Novosti");
        public frmNovostiPrikaz()
        {
            InitializeComponent();
            dgwNovosti.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new NovostiSearchRequest
            {
                Naslov = txtPretraga.Text,

            };
            var result = await _service.get<List<Model.Models.Novosti>>(search);
            dgwNovosti.DataSource = result;
        }

        private async void frmNovostiPrikaz_Load(object sender, EventArgs e)
        {
            await LoadNovosti();
        }

        public async Task LoadNovosti()
        {
            var result = await _service.get<List<Model.Models.Novosti>>(null);
            dgwNovosti.DataSource = result;
        }
        private async void dgwNovosti_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwNovosti.SelectedRows[0].Cells[0].Value;
            var novost = await _service.getByID<Model.Models.Novosti>(id);
            if(dgwNovosti.CurrentCell is DataGridViewButtonCell && novost != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete novost '{novost.Naslov}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadNovosti();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.Soba>(novost.Id);
                    await LoadNovosti();
                }
            }
            else
            {
                frmNovostiDodaj frm = new frmNovostiDodaj(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadNovosti();
            }
        }
    }
}
