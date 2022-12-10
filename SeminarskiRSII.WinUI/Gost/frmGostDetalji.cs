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

namespace SeminarskiRSII.WinUI.Gost
{
    public partial class frmGostDetalji : Form
    {
        private readonly ApiService _service = new ApiService("Grad");
        private readonly ApiService _gost = new ApiService("Gost");
        private int? _id = null;
        public frmGostDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        private async Task loadGradovi()        // u ovoj funkciji cemo uzeti sve gradove i proslijediti ih na pocetnu formu u comboBox
        {
            var result = await _service.get<List<Model.Models.Grad>>(null);       // Uzimamo sve gradove
            result.Insert(0, new Model.Models.Grad());                           // Ovo sluzi 
            cmbGradID.DisplayMember = "NazivGrada"; // Ovu vrijednost ce nam prikazivati u combuBoxu
            cmbGradID.ValueMember = "Id";
            cmbGradID.DataSource = result;                                // Gradove koje smo dobavili sa apija proslijedjujemo u comboBox GradID
        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var gost = new GostiInsertRequest();       // Dodaje gosta sa podacima potrebnim koje smo ubacili u GostiInsertReqeust
            try
            {
                if (ValidateChildren())
                {
                    var idObj = cmbGradID.SelectedValue;
                    if (int.TryParse(idObj.ToString(), out int id))
                    {
                        gost.GradId = id;
                    }

                    gost.Ime = txtIme.Text;
                    gost.Prezime = txtPrezime.Text;
                    gost.Email = txtEmail.Text;            // popunjavanje podataka 
                    gost.Telefon = txtTelefon.Text;
                    gost.korisnickoIme = txtKorisnickoIme.Text;
                    gost.Lozinka = txtLozinka.Text;
                    gost.PotvrdiLozinku = txtPotvrdiLozinku.Text;
                    if (_id.HasValue)                      // Ako ima vrijednost ID
                    {
                        await _gost.Update<Model.Models.Gost>(_id, gost);      // Vrsimo updatovane postojeceg gosta
                        MessageBox.Show($"Uspjesno ste uerdili podatke");
                        Close();
                    }
                    else                                    // Ako nema ID
                    {
                        await _gost.Insert<Model.Models.Gost>(gost);     // Vrsimo obicno dodavanje gosta
                        MessageBox.Show($"Uspjesno ste dodali gosta {gost.Ime} {gost.Prezime}");
                        Close();
                    }
                }
            }
            catch (Exception)
            {

                MessageBox.Show("Neipsravno uneseni podaci");
            }
        }

        private async void frmGostDetalji_Load(object sender, EventArgs e)
        {
            await loadGradovi();         // Ucitavamo sve gradove u comboBox
            if (_id.HasValue)           // Ako ima id
            {
                var g = await _gost.getByID<Model.Models.Gost>(_id);  // Uzimamo ID gosta i popunjavamo textBox sa postojecim podacima
                txtIme.Text = g.Ime;
                txtPrezime.Text = g.Prezime;
                txtTelefon.Text = g.Telefon;
                txtEmail.Text = g.Email;
                cmbGradID.SelectedValue = g.GradId;
                txtKorisnickoIme.Text = g.KorisnickoIme;
            }
        }
    }
}
