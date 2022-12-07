using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class NotifikacijeInsertRequest
    {
        public string Naslov { get; set; }
        public DateTime? DatumSlanja { get; set; }
        public int? NovostId { get; set; }
        public bool Procitano { get; set; }
    }
}
