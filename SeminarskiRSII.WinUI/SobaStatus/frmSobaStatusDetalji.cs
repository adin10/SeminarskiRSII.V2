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

namespace SeminarskiRSII.WinUI.SobaStatus
{
    public partial class frmSobaStatusDetalji : Form
    {
        private readonly ApiService _service = new ApiService("SobaStatus");
        private int? _id = null;
        public frmSobaStatusDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }

        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var sobaStatus = new SobaStatusInsertRequest()
            {
                Status = txtStatus.Text,
                Opis = txtOpis.Text
            };
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.SobaStatus>(_id, sobaStatus);
                MessageBox.Show("Uspjesno ste uredili podatke");
            }
            else
            {
                await _service.Insert<Model.Models.SobaStatus>(sobaStatus);
                MessageBox.Show("Uspjesno ste dodali status za sobu");
            }
        }

        private async void frmSobaStatusDetalji_Load(object sender, EventArgs e)
        {
            if (_id.HasValue)
            {
                var sobaStatus = await _service.getByID<Model.Models.SobaStatus>(_id);
                txtStatus.Text = sobaStatus.Status;
                txtOpis.Text = sobaStatus.Opis;
            }
        }
    }
}
