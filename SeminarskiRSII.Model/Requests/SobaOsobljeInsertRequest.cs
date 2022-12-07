using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class SobaOsobljeInsertRequest
    {
        [Required]

        public int SobaId { get; set; }
        [Required]

        public int OsobljeId { get; set; }
    }
}
