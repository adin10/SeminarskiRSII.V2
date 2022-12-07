using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class SobaOsoblje
    {
        public int Id { get; set; }
        public int SobaId { get; set; }
        public int OsobljeId { get; set; }

        public Osoblje Osoblje { get; set; }
        public Soba Soba { get; set; }
    }
}
