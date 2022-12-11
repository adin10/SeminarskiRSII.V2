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
        public Task<List<Novosti>> GetList(NovostiSearchRequest search);
        public Task<Novosti> Get(int ID);
        public Task<Novosti> Insert(NovostiInsertRequest insert);
        public Task<Novosti> Update(int ID, NovostiInsertRequest update);
        public Task<Novosti> Delete(int id);
    }
}
