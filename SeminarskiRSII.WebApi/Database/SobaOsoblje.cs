using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class SobaOsoblje
    {
        public int Id { get; set; }
        public int SobaId { get; set; }
        public int OsobljeId { get; set; }

        public virtual Osoblje Osoblje { get; set; } = null!;
        public virtual Soba Soba { get; set; } = null!;
    }
}
