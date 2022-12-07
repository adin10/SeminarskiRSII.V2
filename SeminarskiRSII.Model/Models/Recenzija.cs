using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Recenzija
    {
        public int Id { get; set; }
        public int gostID { get; set; }
        public Gost gost { get; set; }
        public int sobaID { get; set; }
        public Soba soba { get; set; }
        public int Ocjena { get; set; }
        public string Komentar { get; set; }
        
    }
}
