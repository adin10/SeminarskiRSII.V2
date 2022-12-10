using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WinUI.Helper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Soba
{
    public partial class frmSobaDodaj : Form
    {
        private readonly ApiService _service = new ApiService("Soba");
        private readonly ApiService _sobaStatus = new ApiService("SobaStatus");
        private int? _id = null;
        public frmSobaDodaj(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        private async Task loadSobaStatus()
        {
            var result = await _sobaStatus.get<List<Model.Models.SobaStatus>>(null);
            result.Insert(0, new Model.Models.SobaStatus());
            cmbStatusID.DisplayMember = "Status";
            cmbStatusID.ValueMember = "Id";
            cmbStatusID.DataSource = result;

        }

        SobaInsertRequest soba = new SobaInsertRequest();

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var idobj = cmbStatusID.SelectedValue;
            if (int.TryParse(idobj.ToString(), out int id))
            {
                soba.SobaStatusId = id;
            }
            soba.BrojSobe = int.Parse(txtBrojSobe.Text);
            soba.BrojSprata = int.Parse(txtBrojSprata.Text);
            soba.OpisSobe = txtInformacije.Text;
            soba.PictureName = txtPictureName.Text;
            soba.PicturePath = txtPicturePath.Text;
            if (_id.HasValue)
            {
                soba.Slika = ImageHelper.FromImageToByte(pbSoba.Image);
                await _service.Update<Model.Models.Soba>(_id, soba);
                MessageBox.Show("Uspjesno ste uredili podatke ");
                Close();
            }
            else
            {
                await _service.Insert<Model.Models.Soba>(soba);
                MessageBox.Show("Uspjesno ste dodali sobu ");
                Close();
            }
        }

        private void btnUcitajSobu_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                var PutanjaDoFila = openFileDialog.FileName;
                Image slika = Image.FromFile(PutanjaDoFila);
                soba.Slika = Helper.ImageHelper.FromImageToByte(slika);
                pbSoba.Image = slika;
            }
        }

        private async void frmSobaDodaj_Load(object sender, EventArgs e)
        {
            await loadSobaStatus();
            if (_id.HasValue)
            {
                var s = await _service.getByID<Model.Models.Soba>(_id);
                txtBrojSobe.Text = s.BrojSobe.ToString();
                txtBrojSprata.Text = s.BrojSprata.ToString();
                txtInformacije.Text = s.OpisSobe;
                cmbStatusID.SelectedValue = s.SobaStatusId;
                pbSoba.Image = Helper.ImageHelper.FromByteToImage(s.Slika);
            }
        }

        private void pbSoba_Click(object sender, EventArgs e)
        {

        }

        private void txtBrojSobe_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtBrojSobe.Text))
            {
                errorProvider.SetError(txtBrojSobe, "Obavezno polje");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtBrojSobe, null);
            }
        }

        private void txtBrojSprata_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtBrojSprata.Text))
            {
                errorProvider.SetError(txtBrojSprata, "Obavezno polje");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtBrojSprata, null);
            }
        }

        private void txtInformacije_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtInformacije.Text))
            {
                errorProvider.SetError(txtInformacije, "Obavezno polje");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtInformacije, null);
            }
        }

        private void cmbStatusID_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(cmbStatusID.Text))
            {
                errorProvider.SetError(cmbStatusID, "Obavezno polje");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(cmbStatusID, null);
            }
        }

        private void pbSoba_Validating(object sender, CancelEventArgs e)
        {
            if (pbSoba.Image == null)
            {
                errorProvider.SetError(pbSoba, "Obavezno polje");
            }
            else
            {
                errorProvider.SetError(pbSoba, null);
            }
        }
    }
}
