using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.Models
{
    public class RecenzijeZaSobuIzvjetsaj
    {
        public int BrojSobe { get; set; }
        public int BrojSprata { get; set; }
        public string OpisSobe { get; set; }
        public byte[] Slika { get; set; }
        public List<RecenzijaZaSobuInfo> Recenzije { get; set; }
    }

    public class RecenzijaZaSobuInfo
    {
        public int Ocjena { get; set; }
        public string Komentar { get; set; }
        public string GostIme { get; set; }
        public string GostPrezime { get; set; }
    }
}
