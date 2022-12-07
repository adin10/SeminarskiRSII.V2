using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Grad
    {
        public Grad()
        {
            Gost = new HashSet<Gost>();
        }

        public int Id { get; set; }
        public string? NazivGrada { get; set; }
        public int PostanskiBroj { get; set; }
        public int DrzavaId { get; set; }

        public virtual Drzava Drzava { get; set; } = null!;
        public virtual ICollection<Gost> Gost { get; set; }
    }
}
