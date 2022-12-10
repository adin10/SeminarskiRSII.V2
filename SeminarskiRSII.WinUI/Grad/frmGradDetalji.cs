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
    public partial class frmGradDetalji : Form
    {
        private readonly ApiService _service = new ApiService("Grad");
        private readonly ApiService _drzave = new ApiService("Drzava");
        private int? _id = null;
        public frmGradDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        private async Task loadDrzave()
        {
            var drzave = await _drzave.get<List<Model.Models.Drzava>>(null);
            drzave.Insert(0, new Model.Models.Drzava());
            cmbDrzave.DisplayMember = "Naziv";
            cmbDrzave.ValueMember = "Id";
            cmbDrzave.DataSource = drzave;
        }
        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var grad = new GradInsertRequest();
            var idObj = cmbDrzave.SelectedValue;
            if (int.TryParse(idObj.ToString(), out int id))
            {
                grad.DrzavaId = id;
            }
            grad.NazivGrada = txtNaziv.Text;
            grad.PostanskiBroj = int.Parse(txtPostanskiBroj.Text);
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.Grad>(_id, grad);
                MessageBox.Show("Uspjesno ste uredili podatke grada ");
                Close();
            }
            else
            {
                await _service.Insert<Model.Models.Grad>(grad);
                MessageBox.Show($"Uspjesno ste dodali grad {grad.NazivGrada}");
                Close();
            }
        }

        private async void frmGradDetalji_Load(object sender, EventArgs e)
        {
            await loadDrzave();
            if (_id.HasValue)
            {
                var grad = await _service.getByID<Model.Models.Grad>(_id);
                txtNaziv.Text = grad.NazivGrada;
                txtPostanskiBroj.Text = grad.PostanskiBroj.ToString();
                cmbDrzave.SelectedValue = grad.DrzavaId;
            }
        }
    }
}
