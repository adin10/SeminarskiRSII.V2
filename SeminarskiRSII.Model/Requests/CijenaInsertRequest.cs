using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class CijenaInsertRequest
    {
        
        public int SobaId { get; set; }
        public string Valuta { get; set; }       
        public float Cijena { get; set; }
    }
}
