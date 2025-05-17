using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace SeminarskiRSII.Model.Models
{
   public class Soba
    {
        public int Id { get; set; }
        public int BrojSprata { get; set; }
        public int BrojSobe { get; set; }
        public string? OpisSobe { get; set; }
        public byte[] Slika { get; set; }
        public string? PictureName { get; set; }
        public string? PicturePath { get; set; }
        public string? StatusSobe { get; set; }

        [NotMapped]
        public float? Cijena { get; set; }
        [NotMapped]
        public int? CijenaId { get; set; }
        [NotMapped]
        public string? Valuta { get; set; }
        [NotMapped]
        public float? ProsjecnaOcjena { get; set; }

        [NotMapped]
        public int? BrojRezervacijaUZadnjuGodinu { get; set; }


        public override string ToString()
        {
            return BrojSobe.ToString();
        }
    }
}
