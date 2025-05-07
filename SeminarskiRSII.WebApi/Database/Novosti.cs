using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Novosti
    {
        public Novosti()
        {
            Notifikacije = new HashSet<Notifikacije>();
        }

        public int Id { get; set; }
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public DateTime? DatumObjave { get; set; }
        public int OsobljeId { get; set; }
        public byte[]? Slika { get; set; }
        public virtual Osoblje Osoblje { get; set; } = null!;
        public virtual ICollection<Notifikacije> Notifikacije { get; set; }
    }
}
