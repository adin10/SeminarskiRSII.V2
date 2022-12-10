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

namespace SeminarskiRSII.WinUI.VrstaOsoblja
{
    public partial class frmVrstaOsobljaDetalji : Form
    {
        private readonly ApiService _service = new ApiService("VrstaOsoblja");
        private int? _id = null;
        public frmVrstaOsobljaDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var o = new VrstaOsobljaInsertRequest()
            {
                Pozicija = txtPozicija.Text,
                Zaduzenja = txtZaduzenja.Text
            };
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.VrstaOsoblja>(_id, o);
                MessageBox.Show("Uspjesno ste promjenili vrstu osoblja");
                Close();
            }
            else
            {
                await _service.Insert<Model.Models.VrstaOsoblja>(o);
                MessageBox.Show($"Uspjesno ste dodali {o.Pozicija} u vrstu osoblja");
                Close();
            }
        }

        private async void frmVrstaOsobljaDetalji_Load(object sender, EventArgs e)
        {
            if (_id.HasValue)
            {

                var entity = await _service.getByID<Model.Models.VrstaOsoblja>(_id);
                txtPozicija.Text = entity.Pozicija;
                txtZaduzenja.Text = entity.Zaduzenja;
            }
        }
    }
}
