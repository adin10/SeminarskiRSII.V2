using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class SobaInsertRequest
    {
        public int BrojSprata { get; set; }
        public int BrojSobe { get; set; }
        public string? OpisSobe { get; set; }
        public byte[] Slika { get; set; }
        public int? SobaStatusId { get; set; }
        public string? PictureName { get; set; }
        public string? PicturePath { get; set; }

    }
}
