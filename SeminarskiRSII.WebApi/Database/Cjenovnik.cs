using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class Cjenovnik
    {
        public int Id { get; set; }
        public int SobaId { get; set; }
        public string? Valuta { get; set; }
        public float Cijena { get; set; }
        public virtual Soba Soba { get; set; } = null!;
    }
}
