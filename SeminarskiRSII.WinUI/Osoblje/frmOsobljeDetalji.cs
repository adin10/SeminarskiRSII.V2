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

namespace SeminarskiRSII.WinUI.Osoblje
{
    public partial class frmOsobljeDetalji : Form
    {
        private readonly ApiService _service = new ApiService("Osoblje");
        private readonly ApiService _VrstaOsoblja = new ApiService("VrstaOsoblja");
        private int? _id = null;
        public frmOsobljeDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }

        OsobljeInsertRequest osoblje = new OsobljeInsertRequest();

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateChildren())
                {

                    osoblje.Ime = txtIme.Text;
                    osoblje.Prezime = txtprezime.Text;
                    osoblje.Telefon = txtTelefon.Text;
                    osoblje.Email = txtEmail.Text;
                    osoblje.KorisnickoIme = txtKorisnickoIme.Text;
                    osoblje.Lozinka = txtLozinka.Text;
                    osoblje.PotvrdiLozinku = txtPotvrdiLozinku.Text;
                    if (_id.HasValue)
                    {
                        osoblje.Slika = Helper.ImageHelper.FromImageToByte(pbOsoblje.Image);
                        await _service.Update<Model.Models.Osoblje>(_id, osoblje);
                        MessageBox.Show("Uspjesno ste uredili podatke o uposleniku");
                        Close();
                    }
                    else
                    {
                        await _service.Insert<Model.Models.Osoblje>(osoblje);
                        MessageBox.Show($"Uspjesno ste dodali zaposlenika {osoblje.Ime} {osoblje.Prezime}");
                        Close();
                    }
                }
            }
            catch (Exception)
            {

                MessageBox.Show("Neispravno uneseni podaci");
            }
        }

        private async void frmOsobljeDetalji_Load(object sender, EventArgs e)
        {
            if (_id.HasValue)
            {
                var g = await _service.getByID<Model.Models.Osoblje>(_id);
                txtIme.Text = g.Ime;
                txtprezime.Text = g.Prezime;
                txtTelefon.Text = g.Telefon;
                txtEmail.Text = g.Email;
                txtKorisnickoIme.Text = g.KorisnickoIme;
                pbOsoblje.Image = Helper.ImageHelper.FromByteToImage(g.Slika);
            }
        }

        private void txtIme_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIme.Text))
            {
                errorProvider.SetError(txtIme, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(txtIme, null);
            }
        }

        private void txtprezime_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtprezime.Text))
            {
                errorProvider.SetError(txtprezime, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(txtprezime, null);
            }
        }

        private void txtTelefon_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTelefon.Text))
            {
                errorProvider.SetError(txtTelefon, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(txtTelefon, null);
            }
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                errorProvider.SetError(txtEmail, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(txtEmail, null);

            }
        }

        private void txtKorisnickoIme_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtKorisnickoIme.Text))
            {
                errorProvider.SetError(txtKorisnickoIme, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(txtKorisnickoIme, null);

            }
        }

        private void pbOsoblje_Validating(object sender, CancelEventArgs e)
        {
            if (pbOsoblje.Image == null)
            {
                errorProvider.SetError(pbOsoblje, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(pbOsoblje, null);
            }
        }

        private void btnDodajSliku_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                var PutanjaDoFila = openFileDialog.FileName;
                Image slika = Image.FromFile(PutanjaDoFila);
                osoblje.Slika = Helper.ImageHelper.FromImageToByte(slika);
                pbOsoblje.Image = slika;
            }
        }
    }
}
