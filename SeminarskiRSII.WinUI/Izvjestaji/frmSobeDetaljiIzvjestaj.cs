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
    public partial class frmSobeDetaljiIzvjestaj : Form
    {

        private readonly ApiService _sobaService = new ApiService("Soba");
        private readonly ApiService _rezervacijeService = new ApiService("Rezervacija");

        int id;
        public frmSobeDetaljiIzvjestaj(int _id)
        {
            InitializeComponent();
            id = _id;
        }

        private async void frmSobeDetaljiIzvjestaj_Load(object sender, EventArgs e)
        {
            var soba = await _sobaService.getByID<Model.Models.Soba>(id);
            ReportParameterCollection rpc = new ReportParameterCollection();
            rpc.Add(new ReportParameter("BrojSobe", soba.BrojSobe.ToString()));
            rpc.Add(new ReportParameter("datumIzdavanja", DateTime.Now.ToString("dd.MM.yyyy HH:mm")));

            var listaRezervacija =await _rezervacijeService.get<List<Model.Models.Rezervacija>>(new RezervacijaSearchRequest() { BrojSobe=soba.BrojSobe});
            dsSobe.tblSobeDataTable tbl = new dsSobe.tblSobeDataTable();
            foreach(var sobe in listaRezervacija)
            {
                dsSobe.tblSobeRow row = tbl.NewtblSobeRow();
                row.gost = sobe.Gost.Ime + " " + sobe.Gost.Prezime;
                row.DatumDolaska = sobe.DatumRezervacije.ToString();
                row.DatumOdlaska = sobe.ZavrsetakRezervacije.ToString();
                tbl.Rows.Add(row);
            }
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "Sobe";
            rds.Value = tbl;
            reportViewer1.LocalReport.SetParameters(rpc);
            reportViewer1.LocalReport.DataSources.Add(rds);
            this.reportViewer1.RefreshReport();
        }

        private void reportViewer1_Load(object sender, EventArgs e)
        {

        }
    }
}
