using SeminarskiRSII.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface ILoginService
    {
        Osoblje Authenticiraj(string username, string pass);
        Osoblje AuthenticirajGosta(string username, string pass);
    }
}
