using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Cjenovnik
    {
        public int Id { get; set; }
        public int SobaId { get; set; }
        public float Cijena { get; set; }
        public string? Valuta { get; set; }
        public DateTime VrijediOd { get; set; }
        public DateTime VrijediDo { get; set; }
        public Soba Soba { get; set; }
    }
}
