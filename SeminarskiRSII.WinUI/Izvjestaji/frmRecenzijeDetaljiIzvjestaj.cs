using Microsoft.Reporting.WinForms;
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

namespace SeminarskiRSII.WinUI.Izvjestaji
{
    public partial class frmRecenzijeDetaljiIzvjestaj : Form
    {
        private readonly ApiService _sobaService = new ApiService("Soba");
        private readonly ApiService _recenzijaService = new ApiService("Recenzija");
        int id;
        public frmRecenzijeDetaljiIzvjestaj(int _id)
        {
            id = _id;
            InitializeComponent();
        }

        private async void frmRecenzijeDetaljiIzvjestaj_Load(object sender, EventArgs e)
        {
            var soba = await _sobaService.getByID<Model.Models.Soba>(id);
            ReportParameterCollection rpc = new ReportParameterCollection();
            rpc.Add(new ReportParameter("BrojSobe", soba.BrojSobe.ToString()));
            rpc.Add(new ReportParameter("datumIzdavanja", DateTime.Now.ToString("dd.MM.yyyy HH:mm")));

            var listaRecenzija = await _recenzijaService.get<List<Model.Models.Recenzija>>(new RecenzijaSearchRequest() { BrojSobe = soba.BrojSobe });
            dsRecenzije.tblRecenzijeDataTable tbl = new dsRecenzije.tblRecenzijeDataTable();
            foreach (var recenzije in listaRecenzija)
            {
                dsRecenzije.tblRecenzijeRow row = tbl.NewtblRecenzijeRow();
                row.ImePrezime = recenzije.gost.Ime + " " + recenzije.gost.Prezime;
                row.Ocjena = recenzije.Ocjena.ToString();
                row.Komentar = recenzije.Komentar;
                tbl.Rows.Add(row);
            }
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "Recenzije";
            rds.Value = tbl;
            reportViewer1.LocalReport.SetParameters(rpc);
            reportViewer1.LocalReport.DataSources.Add(rds);
            this.reportViewer1.RefreshReport();
        }
    }
}
