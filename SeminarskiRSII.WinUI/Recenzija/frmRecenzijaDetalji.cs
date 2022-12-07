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

namespace SeminarskiRSII.WinUI.Recenzija
{
    public partial class frmRecenzijaDetalji : Form
    {
        private readonly ApiService _service = new ApiService("Recenzija");
        private readonly ApiService _gost = new ApiService("Gost");
        private readonly ApiService _soba = new ApiService("Soba");
        private int? _id = null;
        public frmRecenzijaDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        private async Task loadSoba()
        {
            var list = await _soba.get<List<Model.Models.Soba>>(null);
            list.Insert(0, new Model.Models.Soba());
            cmbSoba.ValueMember = "Id";
            cmbSoba.DisplayMember = "BrojSobe";
            cmbSoba.DataSource = list;
        }
        private async Task loadGosti()
        {
            var list = await _gost.get<List<Model.Models.Gost>>(null);
            list.Insert(0, new Model.Models.Gost());
            cmbGost.ValueMember = "Id";
            cmbGost.DisplayMember = "Ime Prezime";
            cmbGost.DataSource = list;

        }
        RecenzijaInsertRequest recenzija = new RecenzijaInsertRequest();

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var idobj = cmbGost.SelectedValue;
            if (int.TryParse(idobj.ToString(), out int id))
            {
                recenzija.gostID = id;
            }
            var idobj2 = cmbSoba.SelectedValue;
            if (int.TryParse(idobj2.ToString(), out int id2))
            {
                recenzija.sobaID = id2;
            }
            recenzija.Ocjena = int.Parse(txtOcjena.Text);
            recenzija.Komentar = txtKomentar.Text;
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.Recenzija>(_id, recenzija);
                MessageBox.Show("Uspjesno ste uredili podatke");
            }
            else
            {
                await _service.Insert<Model.Models.Recenzija>(recenzija);
                MessageBox.Show("Uspjesno ste dodali ocjenu i komentar");
            }
        }

        private async void frmRecenzijaDetalji_Load(object sender, EventArgs e)
        {
            await loadGosti();
            await loadSoba();
            if (_id.HasValue)
            {
                var recenzija = await _service.getByID<Model.Models.Recenzija>(_id);
                cmbGost.SelectedValue = recenzija.gostID;
                cmbSoba.SelectedValue = recenzija.sobaID;
                txtOcjena.Text = recenzija.Ocjena.ToString();
                txtKomentar.Text = recenzija.Komentar;
            }
        }
    }
}
