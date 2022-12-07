using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class GradSearchRequest
    {
        public string? NazivGrada { get; set; }
        public int PostanskiBroj { get; set; }
        public int? DrzavaId { get; set; }
    }
}
