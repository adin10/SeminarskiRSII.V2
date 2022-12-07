using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class VrstaOsoblja
    {
        public VrstaOsoblja()
        {
            OsobljeUloge = new HashSet<OsobljeUloge>();
        }

        public int Id { get; set; }
        public string? Pozicija { get; set; }
        public string? Zaduzenja { get; set; }

        public virtual ICollection<OsobljeUloge> OsobljeUloge { get; set; }
    }
}
