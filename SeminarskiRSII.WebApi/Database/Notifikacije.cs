using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Notifikacije
    {
        public Notifikacije()
        {
            GostiNotifikacije = new HashSet<GostiNotifikacije>();
        }

        public int Id { get; set; }
        public string? Naslov { get; set; }
        public DateTime DatumSlanja { get; set; }
        public int NovostId { get; set; }

        public virtual Novosti Novost { get; set; } = null!;
        public virtual ICollection<GostiNotifikacije> GostiNotifikacije { get; set; }
    }
}
