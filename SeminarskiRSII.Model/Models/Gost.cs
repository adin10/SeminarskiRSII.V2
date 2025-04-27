using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Gost
    {
        public int Id { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        public int? GradId { get; set; }
        public Grad Grad { get; set; }
        public string KorisnickoIme { get; set; }
        public string LozinkaHash { get; set; }
        public string LozinkaSalt { get; set; }
        public DateTime DatumRegistracije { get; set; }
        public bool Status { get; set; }
        //public string Grad { get; set; }
        public override string ToString()
        {
            return Ime + " " + Prezime;
        }
    }
}
