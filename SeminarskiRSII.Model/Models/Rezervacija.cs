using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Rezervacija
    {
        public int Id { get; set; }
        public DateTime DatumRezervacije { get; set; }
        public DateTime ZavrsetakRezervacije { get; set; }
        public ICollection<RezervacijaUsluge> RezervacijaUsluge { get; set; }
        public float Cijena { get; set; }
        public int? GostId { get; set; }
        public Gost Gost { get; set; }
        public int? SobaId { get; set; }
        public Soba Soba { get; set; }
    }
}
