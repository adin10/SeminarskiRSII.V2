using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
    public class GostiSearchRequest
    {
        public string? ime { get; set; }
        public string? prezime { get; set; }
        public int? gradID { get; set; }
        public string? KorisnickoIme { get; set; }
    }
}
