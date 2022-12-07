using Flurl.Http;
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

namespace SeminarskiRSII.WinUI
{
    public partial class frmLogin : Form
    {

       ApiService _ulogeService = new ApiService("VrstaOsoblja");
       ApiService _osobljeService = new ApiService("Osoblje");

        public frmLogin()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            try
            {
                ApiService.Username = txtKorisnickoIme.Text;
                ApiService.Password = txtPassword.Text;
                //await _ulogeService.get<dynamic>(null);
                var list = await _osobljeService.get<List<Model.Models.Osoblje>>(new OsobljeSearchRequest() {korisnickoIme = ApiService.Username});
                Model.Models.Osoblje item = list.Where(x => x.KorisnickoIme == ApiService.Username).FirstOrDefault();
                if (item != null)
                {
                    var frm = new frmPocetna();
                    frm.Show();
                }
                else
                {
                    MessageBox.Show("Pogrešno korisničko ime ili lozinka!");
                }
            }
            catch (FlurlHttpException ex)
            {

                if (ex.Call.Response.ResponseMessage.StatusCode != System.Net.HttpStatusCode.Unauthorized)
                {
                    MessageBox.Show("Niste pokrenuli API!");
                }
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void frmLogin_Load(object sender, EventArgs e)
        {

        }
    }
}
