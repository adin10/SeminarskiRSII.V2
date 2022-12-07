using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class GostiNotifikacijeInsertRequest
    {
        public int NotifikacijaId { get; set; }
        public int GostId { get; set; }
        public bool Pregledana { get; set; }
    }
}
