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
            await LoadCijene();
        }

        public async Task LoadCijene()
        {
            var list = await _Service.get<List<Model.Models.Cjenovnik>>(null);
            dgwCjenovnik.DataSource = list;
        }

        private async void dgwCjenovnik_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwCjenovnik.SelectedRows[0].Cells[0].Value;
            var cijena = await _Service.getByID<Model.Models.Cjenovnik>(id);
            if(dgwCjenovnik.CurrentCell is DataGridViewButtonCell && cijena != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete cijenu", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (messageBoxConfirmation == DialogResult.No)
                {
                    await LoadCijene();
                }
                else if (messageBoxConfirmation == DialogResult.Yes)
                {
                    await _Service.Delete<Model.Models.Cjenovnik>(cijena.Id);
                    await LoadCijene();
                }
            }
            else
            {
                frmCjenovnikDetalji frm = new frmCjenovnikDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await LoadCijene();
            }
        }
    }
}
