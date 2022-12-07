using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Soba
    {
        public Soba()
        {
            Cjenovnik = new HashSet<Cjenovnik>();
            Recenzija = new HashSet<Recenzija>();
            Rezervacija = new HashSet<Rezervacija>();
            SobaOsoblje = new HashSet<SobaOsoblje>();
        }

        public int Id { get; set; }
        public int BrojSprata { get; set; }
        public int BrojSobe { get; set; }
        public string? OpisSobe { get; set; }
        public byte[]? Slika { get; set; }
        public string? PictureName { get; set; }
        public string? PicturePath { get; set; }
        public int SobaStatusId { get; set; }

        public virtual SobaStatus SobaStatus { get; set; } = null!;
        public virtual ICollection<Cjenovnik> Cjenovnik { get; set; }
        public virtual ICollection<Recenzija> Recenzija { get; set; }
        public virtual ICollection<Rezervacija> Rezervacija { get; set; }
        public virtual ICollection<SobaOsoblje> SobaOsoblje { get; set; }
    }
}
