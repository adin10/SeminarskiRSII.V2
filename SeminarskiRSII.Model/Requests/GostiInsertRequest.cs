using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
    public class GostiInsertRequest
    {
        [Required]
        public string Ime { get; set; }
        [Required]
        public string Prezime { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Telefon { get; set; }
        [Required]
        public int GradId { get; set; }
        [Required]
        public string korisnickoIme { get; set; }
        [Required]
        public string Lozinka { get; set; }
        [Required]
        public string PotvrdiLozinku { get; set; }
    }
}
