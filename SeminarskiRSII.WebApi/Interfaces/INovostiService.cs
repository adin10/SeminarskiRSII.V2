using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface INovostiService
    {
        List<Novosti> GetList(NovostiSearchRequest search);
        Novosti Get(int ID);
        Novosti Insert(NovostiInsertRequest insert);
        Novosti Update(int ID, NovostiInsertRequest update);
    }
}
