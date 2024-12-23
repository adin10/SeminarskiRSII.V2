using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.Models
{

    public class Usluga
    {
        public int UslugaID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public int Cijena { get; set; }
    }
}
