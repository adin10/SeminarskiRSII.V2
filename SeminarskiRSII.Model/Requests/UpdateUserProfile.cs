using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.Requests
{
    public class UpdateUserProfile
    {
        public string KorisnickoIme { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }

    }
}
