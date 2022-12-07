using System;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class OsobljeUloge
    {
        public int OsobljeUlogeId { get; set; }
        public int OsobljeId { get; set; }
        public int VrstaOsobljaId { get; set; }
        public DateTime DatumIzmjene { get; set; }

        public virtual Osoblje Osoblje { get; set; } = null!;
        public virtual VrstaOsoblja VrstaOsoblja { get; set; } = null!;
    }
}
