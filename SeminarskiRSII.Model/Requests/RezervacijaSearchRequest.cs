using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class RezervacijaSearchRequest
    {
        public int? sobaID { get; set; }
        public int? gostID { get; set; }
        public string? ImePrezime { get; set; }
        public int? BrojSobe { get; set; }
        public string? KorisnickoIme { get; set; }
        public bool SamoBuduce { get; set; } = false;
        public DateTime? DatumRezervacije { get; set; }
        public DateTime? ZavrsetakRezervacije { get; set; }

    }
}
