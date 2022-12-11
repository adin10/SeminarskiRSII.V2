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

namespace SeminarskiRSII.WinUI.Soba
{
    public partial class frmSobaPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("Soba");
        private readonly ApiService _sobaStatus = new ApiService("SobaStatus");
        public frmSobaPrikaz()
        {
            InitializeComponent();
            dgwSoba.AutoGenerateColumns = false;
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            int outpoutValue = 0;
            bool ISnumber = false;
            ISnumber = int.TryParse(txtPretraga.Text, out outpoutValue);
            if (!ISnumber)
            {
                var list = await _service.get<List<Model.Models.Soba>>(null);
                MessageBox.Show("Unesite broj sobe koju zelite pretraziti");
            }
            else
            {
                var search = new SobaSearchRequest()
                {

                    BrojSobe = int.Parse(txtPretraga.Text)
                };
                var list = await _service.get<List<Model.Models.Soba>>(search);
                dgwSoba.DataSource = list;
            }
        }

        private async void frmSobaPrikaz_Load(object sender, EventArgs e)
        {
            await LoadSobe();
        }

        public async Task LoadSobe()
        {
            var result = await _service.get<List<Model.Models.Soba>>(null);
            dgwSoba.DataSource = result;
        }

        private async void dgwSoba_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwSoba.SelectedRows[0].Cells[0].Value;
            var soba = await _service.getByID<Model.Models.Soba>(id);
            if(dgwSoba.CurrentCell is DataGridViewButtonCell && soba != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete sobu '{soba.BrojSobe}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadSobe();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.Soba>(soba.Id);
                    await LoadSobe();
                }
            }
            else
            {
                frmSobaDodaj frm = new frmSobaDodaj(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadSobe();
            }

        }
    }
}
