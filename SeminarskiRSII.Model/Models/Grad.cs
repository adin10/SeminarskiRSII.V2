using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Grad
    {
        public int Id { get; set; }
        public string NazivGrada { get; set; }
        public int PostanskiBroj { get; set; }
        public int? DrzavaId { get; set; }
        public Drzava drzava { get; set; }

        public override string ToString()
        {
            return NazivGrada;
        }
    }
}
