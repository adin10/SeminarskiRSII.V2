using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Cjenovnik
    {
        public int Id { get; set; }
        public int SobaId { get; set; }
        public int BrojDana { get; set; }
        public float Cijena { get; set; }

        public Soba Soba { get; set; }
    }
}
