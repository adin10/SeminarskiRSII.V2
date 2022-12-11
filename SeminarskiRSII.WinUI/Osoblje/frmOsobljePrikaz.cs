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

namespace SeminarskiRSII.WinUI.Osoblje
{
    public partial class frmOsobljePrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Osoblje");
        public frmOsobljePrikaz()
        {
            InitializeComponent();
            dgwOsoblje.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new OsobljeSearchRequest()
            {
                ime = txtPretraga.Text,
                prezime = txtPrezime.Text
            };
            var list = await _service.get<List<Model.Models.Osoblje>>(search);
            dgwOsoblje.DataSource = list;
        }

        private async void frmOsobljePrikaz_Load(object sender, EventArgs e)
        {
            await LoadOsoblje();
        }

        public async Task LoadOsoblje()
        {
            var list = await _service.get<List<Model.Models.Osoblje>>(null);
            dgwOsoblje.DataSource = list;
        }

        private async void dgwOsoblje_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwOsoblje.SelectedRows[0].Cells[0].Value;
            var uposlenik = await _service.getByID<Model.Models.Osoblje>(id);
            if (dgwOsoblje.CurrentCell is DataGridViewButtonCell && uposlenik != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Jeste li sigurni da zelite izbrisati uposlenika '{uposlenik.Ime} {uposlenik.Prezime}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadOsoblje();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.Osoblje>(uposlenik.Id);
                    await LoadOsoblje();
                }
            }
            else
            {
                frmOsobljeDetalji frm = new frmOsobljeDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadOsoblje();
            }
        }
    }
}
