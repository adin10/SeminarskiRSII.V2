using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class OsobljeInsertRequest
    {
        [Required]
        public string Ime { get; set; }

        [Required]
        public string Prezime { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string Telefon { get; set; }
        //[Required]
        //public int? VrstaOsobljaId { get; set; }

        [Required]
        public byte[] Slika { get; set; }

        [Required]
        public string KorisnickoIme { get; set; }

        public string? Lozinka { get; set; }

        public string? PotvrdiLozinku { get; set; }

        public List<int> Uloge { get; set; } = new List<int>();
    }
}
