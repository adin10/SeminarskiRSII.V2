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
    public partial class frmNovostiDodaj : Form
    {
        private readonly ApiService _service = new ApiService("Novosti");
        private readonly ApiService _autor = new ApiService("Osoblje");
        private int? _id = null;
        public frmNovostiDodaj(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var obavijest = new NovostiInsertRequest();
            var idobj = cmbAutor.SelectedValue;
            if (int.TryParse(idobj.ToString(), out int id))
            {
                obavijest.OsobljeId = id;
            }
            obavijest.Naslov = txtNaslov.Text;
            obavijest.Sadrzaj = txtSadrzaj.Text;
            obavijest.DatumObjave = DateTime.Now;
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.Novosti>(_id, obavijest);
                MessageBox.Show("Uspjesno ste izmijenili obavijest");
            }
            else
            {
                await _service.Insert<Model.Models.Novosti>(obavijest);
                MessageBox.Show("Uspjesno ste objavili vijest");
            }
        }
        private async Task loadAutore()
        {
            var list = await _autor.get<List<Model.Models.Osoblje>>(null);
            list.Insert(0, new Model.Models.Osoblje());
            cmbAutor.DisplayMember = "Ime Prezime ";
            cmbAutor.ValueMember = "Id";
            cmbAutor.DataSource = list;

        }

        private async void frmNovostiDodaj_Load(object sender, EventArgs e)
        {
            await loadAutore();
            if (_id.HasValue)
            {
                var novosti = await _service.getByID<Model.Models.Novosti>(_id);
                txtNaslov.Text = novosti.Naslov;
                txtSadrzaj.Text = novosti.Sadrzaj;
                dtpDatum.Value = novosti.DatumObjave;
                cmbAutor.SelectedValue = novosti.OsobljeId;
            }
        }
    }
}
