using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        public int? GostId { get; set; }
        public int? SobaId { get; set; }
        public DateTime DatumRezervacije { get; set; }
        public DateTime ZavrsetakRezervacije { get; set; }
    }
}
