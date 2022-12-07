using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public  class RecenzijaInsertRequest
    {
        [Required]
        public int gostID { get; set; }
        [Required]
        public int sobaID { get; set; }
        [Required]
        public int Ocjena { get; set; }
        [Required]
        public string Komentar { get; set; }
    }
}
