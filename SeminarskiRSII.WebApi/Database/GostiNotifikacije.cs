using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class GostiNotifikacije
    {
        public int Id { get; set; }
        public int? NotifikacijeId { get; set; }
        public int GostId { get; set; }
        public bool Pregledana { get; set; }

        public virtual Gost Gost { get; set; } = null!;
        public virtual Notifikacije? Notifikacije { get; set; }
    }
}
