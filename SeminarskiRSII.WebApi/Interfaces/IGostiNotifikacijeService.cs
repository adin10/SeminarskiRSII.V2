using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
   public interface IGostiNotifikacijeService
    {
        public Task<List<GostiNotifikacije>> GetList(GostiNotifikacijeSearchRequest search);
    }
}
