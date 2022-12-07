using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class SobaStatus
    {
        public SobaStatus()
        {
            Soba = new HashSet<Soba>();
        }

        public int Id { get; set; }
        public string? Status { get; set; }
        public string? Opis { get; set; }

        public virtual ICollection<Soba> Soba { get; set; }
    }
}
