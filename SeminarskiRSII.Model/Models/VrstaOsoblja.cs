using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class VrstaOsoblja
    {
        public int Id { get; set; }
        public string Pozicija { get; set; }
        public string Zaduzenja { get; set; }

        public override string ToString()
        {
            return Pozicija;
        }
    }
}
