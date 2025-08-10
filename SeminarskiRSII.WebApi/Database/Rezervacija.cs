using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Rezervacija
    {
        public int Id { get; set; }
        public int GostId { get; set; }
        public int SobaId { get; set; }
        public DateTime DatumRezervacije { get; set; }
        public DateTime ZavrsetakRezervacije { get; set; }
        public byte[]? Qrcode { get; set; }
        public bool? Otkazana { get; set; }
        public bool? Ocjenjena { get; set; }
        public float Cijena { get; set; }
        public ICollection<RezervacijaUsluga> RezervacijaUsluge { get; set; }
        public virtual Gost Gost { get; set; } = null!;
        public virtual Soba Soba { get; set; } = null!;
    }
}
