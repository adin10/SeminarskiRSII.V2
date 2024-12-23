using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.Model.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI.Cjenovnik
{
    public partial class frmCjenovnikDetalji : Form
    {
        private readonly ApiService _service = new ApiService("Cjenovnik");
        private readonly ApiService _soba = new ApiService("Soba");
        private int? _id = null;
        public frmCjenovnikDetalji(int? id = null)
        {
            InitializeComponent();
            _id = id;
        }
        CijenaInsertRequest insert = new CijenaInsertRequest();
        private async Task loadSoba()
        {
            var list = await _soba.get<List<Model.Models.Soba>>(null);
            list.Insert(0, new Model.Models.Soba());
            cmbSoba.ValueMember = "Id";
            cmbSoba.DisplayMember = "BrojSobe";
            cmbSoba.DataSource = list;
        }
        private async void btnSnimi_Click(object sender, EventArgs e)
        {
            var idobj = cmbSoba.SelectedValue;
            if (int.TryParse(idobj.ToString(), out int id))
            {
                insert.SobaId = id;
            }
            insert.Valuta = txtBrojdana.Text;
            insert.Cijena = float.Parse(txtCijena.Text);
            if (_id.HasValue)
            {
                await _service.Update<Model.Models.Cjenovnik>(_id, insert);
                MessageBox.Show("Uspjesno ste uredili podatke");
                Close();
            }
            else
            {
                await _service.Insert<Model.Models.Cjenovnik>(insert);
                MessageBox.Show("Uspjesno ste dodali cijenu ");
                Close();
            }
        }

        private async void frmCjenovnikDetalji_Load(object sender, EventArgs e)
        {
            await loadSoba();
            if (_id.HasValue)
            {
                var list = await _service.getByID<Model.Models.Cjenovnik>(_id);
                cmbSoba.SelectedValue = list.SobaId;
                txtBrojdana.Text = list.Valuta;
                txtCijena.Text = list.Cijena.ToString();
            }
        }
    }
}
