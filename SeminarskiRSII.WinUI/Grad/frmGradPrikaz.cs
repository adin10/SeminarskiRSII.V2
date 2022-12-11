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

namespace SeminarskiRSII.WinUI.Grad
{
    public partial class frmGradPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Grad");
        public frmGradPrikaz()
        {
            InitializeComponent();
            dgwGradovi.AutoGenerateColumns = false;
        }

        private async void btnPrikaz_Click(object sender, EventArgs e)
        {
            var search = new GradSearchRequest()
            {
                NazivGrada = txtpretraga.Text
            };
            var list = await _service.get<List<Model.Models.Grad>>(search);
            dgwGradovi.DataSource = list;
        }

        private async void frmGradPrikaz_Load(object sender, EventArgs e)
        {
            await LoadGradovi();
        }

        public async Task LoadGradovi()
        {
            var list = await _service.get<List<Model.Models.Grad>>(null);
            dgwGradovi.DataSource = list;
        }

        private async void dgwGradovi_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwGradovi.SelectedRows[0].Cells[0].Value;
            var grad = await _service.getByID<Model.Models.Grad>(id);
            if(dgwGradovi.CurrentCell is DataGridViewButtonCell && grad != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete grad '{grad.NazivGrada}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadGradovi();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(grad.Id);
                    await LoadGradovi();
                }
            }
            else
            {
                frmGradDetalji frm = new frmGradDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadGradovi();
            }
        }
    }
}
