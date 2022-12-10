using SeminarskiRSII.Model.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.SobaStatus
{
    public partial class frmSobaStatusPrikaz : Form
    {
        private readonly ApiService _service = new ApiService("SobaStatus");
        public frmSobaStatusPrikaz()
        {
            InitializeComponent();
            dgwSobaStatus.AutoGenerateColumns = false;
        }

        private async void frmSobaStatusPrikaz_Load(object sender, EventArgs e)
        {
            await loadSobaStatuse();
        }

        private async Task loadSobaStatuse()
        {
            var list = await _service.get<List<Model.Models.SobaStatus>>(null);
            dgwSobaStatus.DataSource = list;
        }

        private async void dgwSobaStatus_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            var id = dgwSobaStatus.SelectedRows[0].Cells[0].Value;
            var sobaStatus = await _service.getByID<Model.Models.SobaStatus>(id);
            if(dgwSobaStatus.CurrentCell is DataGridViewButtonCell && sobaStatus != null)
            {
                var messageBoxConfirmation = MessageBox.Show($"Da li ste sigurni da želite da izbrišete status sobe '{sobaStatus.Status}'", "Form closing", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if(messageBoxConfirmation == DialogResult.No)
                {
                    await loadSobaStatuse();
                }
                else if(messageBoxConfirmation == DialogResult.Yes)
                {
                    await _service.Delete<Model.Models.SobaStatus>(sobaStatus.Id);
                    await loadSobaStatuse();
                }
            }
            else
            {
                frmSobaStatusDetalji frm = new frmSobaStatusDetalji(int.Parse(id.ToString()));
                frm.ShowDialog();
                await loadSobaStatuse();
            }
        }
    }
}
