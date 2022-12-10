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

namespace SeminarskiRSII.WinUI.SobaOsoblje
{
    public partial class frmSobaOsobljeDetalji : Form
    {
        private readonly ApiService _service = new ApiService("SobaOsoblje");
        private readonly ApiService _soba = new ApiService("Soba");
        private readonly ApiService _osoblje = new ApiService("Osoblje");
        private int? _id = null;
        public frmSobaOsobljeDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        private async Task loadSobe()
        {
            var list = await _soba.get<List<Model.Models.Soba>>(null);
            list.Insert(0, new Model.Models.Soba());
            cmbSoba.ValueMember = "Id";
            cmbSoba.DisplayMember = "BrojSobe";
            cmbSoba.DataSource = list;
        }
        private async Task loadOsoblje()
        {
            var list = await _osoblje.get<List<Model.Models.Osoblje>>(null);
            list.Insert(0, new Model.Models.Osoblje());
            cmbOsoblje.ValueMember = "Id";
            cmbOsoblje.DisplayMember = "Ime Prezime";
            cmbOsoblje.DataSource = list;
        }


        SobaOsobljeInsertRequest insert = new SobaOsobljeInsertRequest();

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var idobj = cmbSoba.SelectedValue;
            if (int.TryParse(idobj.ToString(), out int sobaID))
            {
                insert.SobaId = sobaID;
            }
            var idobj2 = cmbOsoblje.SelectedValue;
            if (int.TryParse(idobj2.ToString(), out int osobljeID))
            {
                insert.OsobljeId = osobljeID;
            }
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.SobaOsoblje>(_id, insert);
                MessageBox.Show("Uspjesno ste uredili podatke");
                Close();
            }
            else
            {
                await _service.Insert<Model.Models.SobaOsoblje>(insert);
                MessageBox.Show("Uspjesno ste dodjelili sobu uposleniku ");
                Close();
            }
        }

        private async void frmSobaOsobljeDetalji_Load(object sender, EventArgs e)
        {
            await loadOsoblje();
            await loadSobe();
            if (_id.HasValue)
            {
                var list = await _service.getByID<Model.Models.SobaOsoblje>(_id);
                cmbOsoblje.SelectedValue = list.OsobljeId;
                cmbSoba.SelectedValue = list.SobaId;
            }
        }
    }
}
