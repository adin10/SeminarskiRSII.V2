using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Osoblje
    {
        public int Id { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string KorisnickoIme { get; set; }
        public string Telefon { get; set; }
        public byte[] Slika { get; set; }
        public string Lozinka { get; set; }
        public string PotvrdiLozinku { get; set; }
        public ICollection<OsobljeUloge> OsobljeUloge { get; set; }
        public string Uloge { get; set; }


        public override string ToString()
        {
            return Ime + " " + Prezime;
        }
    }
}
