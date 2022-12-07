using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class NovostiSearchRequest
    {
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; }
        public DateTime? DatumObjave { get; set; }
        public int? OsobljeId { get; set; }
    }
}
