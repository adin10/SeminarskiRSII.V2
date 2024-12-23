using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.Models
{
    public class RezervacijaUsluge
    {
        public int RezervacijaUslugaID { get; set; }
        public int? RezervacijaID { get; set; }
        public Rezervacija? Rezervacija { get; set; }
        public int? UslugaId { get; set; }
        public Usluga? Usluga { get; set; }
    }
}
