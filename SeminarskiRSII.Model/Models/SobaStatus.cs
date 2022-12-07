using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class SobaStatus
    {
        public int Id { get; set; }
        public string Status { get; set; }
        public string Opis { get; set; }

        public override string ToString()
        {
            return Status;
        }
    }
}
