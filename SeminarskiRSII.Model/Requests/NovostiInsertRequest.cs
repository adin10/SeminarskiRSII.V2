using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class NovostiInsertRequest
    {
        [Required]
        public string Naslov { get; set; }
        [Required]
        public string Sadrzaj { get; set; }
        [Required]
        public DateTime DatumObjave { get; set; }
        [Required]
        public int? OsobljeId { get; set; }
    }
}
