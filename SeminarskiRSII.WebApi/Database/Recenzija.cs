using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Recenzija
    {
        public int Id { get; set; }
        public int GostId { get; set; }
        public int SobaId { get; set; }
        public int Ocjena { get; set; }
        public string? Komentar { get; set; }
        public DateTime DatumRecenzije { get; set; }

        public virtual Gost Gost { get; set; } = null!;
        public virtual Soba Soba { get; set; } = null!;
    }
}
