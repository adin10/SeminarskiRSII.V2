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
    public partial class frmDodajDrzavu : Form
    {
        private readonly ApiService _service = new ApiService("Drzava");
        private int? _id = null;  // Id pomocu kojeg cemo znati da li radimo insert ili update
        public frmDodajDrzavu(int? DrzavaID = null)
        {
            InitializeComponent();
            _id = DrzavaID;
        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var drzava = new DrzavaSearchRequest()
            {
                naziv = txtNaziv.Text
            };
            if (_id.HasValue) // Ako ima id radimo update i trebamo imat popunjena polja
            {
                await _service.Update<Model.Models.Drzava>(_id, drzava);
                MessageBox.Show("Uspjesno ste uredili podatke o drzavi ");
            }

            else
            {
                await _service.Insert<Model.Models.Drzava>(drzava);
                MessageBox.Show("Uspjesno ste dodali drzavu ");
            }
        }

        private async void frmDodajDrzavu_Load(object sender, EventArgs e)
        {
            if (_id.HasValue)
            {
                var drzava = await _service.getByID<Model.Models.Drzava>(_id);
                txtNaziv.Text = drzava.Naziv;   // Popuni text box nazivm drzave na koju smo kliknuli dva put
            }
        }

        private void txtNaziv_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNaziv.Text))
            {
                errorProvider.SetError(txtNaziv, "Obavezno polje");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtNaziv, null);
            }
        }
    }
}
