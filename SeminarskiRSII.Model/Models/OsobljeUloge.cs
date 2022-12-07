using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class OsobljeUloge
    {
        public int OsobljeUlogeId { get; set; }
        public int OsobljeID { get; set; }
        public Osoblje Osoblje { get; set; }
        public int VrstaOsobljaID { get; set; }
        public VrstaOsoblja VrstaOsoblja { get; set; }
        public DateTime DatumIzmjene { get; set; }
    }
}
