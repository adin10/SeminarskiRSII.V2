using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class OsobljeSearchRequest
    {
        public string? ime { get; set; }
        public string? prezime { get; set; }
        public string? korisnickoIme { get; set; }
        public int? vrstaOsobljaID { get; set; }
    }
}
