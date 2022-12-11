using SeminarskiRSII.Model.Models;
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

namespace SeminarskiRSII.WinUI.Drzava
{
    public partial class frmDrzavaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Drzava");
        public frmDrzavaPrikaz()
        {
            InitializeComponent();
            dgwDrzave.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new DrzavaSearchRequest()
            {
                naziv = txtPretraga.Text
            };
            var result = await _service.get<List<Model.Models.Drzava>>(search);  // Uzimamo listu drzava sa apija

            dgwDrzave.DataSource = result;       // Dodjeljujemo data grid viewu drzave sa apija
        }

        private async void frmDrzavaPrikaz_Load(object sender, EventArgs e)
        {
            await LoadDrzave();
        }

        public async Task LoadDrzave()
        {
            var result = await _service.get<List<Model.Models.Drzava>>(null);
            dgwDrzave.DataSource = result;
        }

        private async void dgwDrzave_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwDrzave.SelectedRows[0].Cells[0].Value;
            var drzava = await _service.getByID<Model.Models.Drzava>(id);
            if(dgwDrzave.CurrentCell is DataGridViewButtonCell && drzava != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete drzavu '{drzava.Naziv}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadDrzave();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(drzava.Id);
                    await LoadDrzave();
                }
            }
            else
            {
                frmDodajDrzavu frm = new frmDodajDrzavu(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadDrzave();
            }
        }
    }
}
