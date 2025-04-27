using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Gost
    {
        public Gost()
        {
            GostiNotifikacije = new HashSet<GostiNotifikacije>();
            Recenzija = new HashSet<Recenzija>();
            Rezervacija = new HashSet<Rezervacija>();
        }

        public int Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Email { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? LozinkaHash { get; set; }
        public string? LozinkaSalt { get; set; }
        public string? Telefon { get; set; }
        public int GradId { get; set; }
        public DateTime DatumRegistracije { get; set; }
        public bool Status { get; set; }

        public virtual Grad Grad { get; set; } = null!;
        public virtual ICollection<GostiNotifikacije> GostiNotifikacije { get; set; }
        public virtual ICollection<Recenzija> Recenzija { get; set; }
        public virtual ICollection<Rezervacija> Rezervacija { get; set; }
    }
}
