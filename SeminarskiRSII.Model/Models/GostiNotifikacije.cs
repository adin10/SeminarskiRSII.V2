using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class GostiNotifikacije
    {
        public int Id { get; set; }
        public int NotifikacijeId { get; set; }
        public int gostID { get; set; }
        public bool Pregledana { get; set; }

        public virtual Notifikacije Notifikacije { get; set; }
        public virtual Gost gost { get; set; }
    }
}
