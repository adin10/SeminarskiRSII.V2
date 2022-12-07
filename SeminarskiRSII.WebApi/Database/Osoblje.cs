using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Osoblje
    {
        public Osoblje()
        {
            Novosti = new HashSet<Novosti>();
            OsobljeUloge = new HashSet<OsobljeUloge>();
            SobaOsoblje = new HashSet<SobaOsoblje>();
        }

        public int Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Email { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? LozinkaHash { get; set; }
        public string? LozinkaSalt { get; set; }
        public string? Telefon { get; set; }
        public byte[]? Slika { get; set; }

        public virtual ICollection<Novosti> Novosti { get; set; }
        public virtual ICollection<OsobljeUloge> OsobljeUloge { get; set; }
        public virtual ICollection<SobaOsoblje> SobaOsoblje { get; set; }
    }
}
