using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface IOsobljeService
    {
        public Task<List<Osoblje>> GetList(OsobljeSearchRequest search);
        public Task<Osoblje> Get(int id);
        public Task<Osoblje> Insert(OsobljeInsertRequest insert);
        public Task<Osoblje> Update(int id, OsobljeInsertRequest update);

        public Task<Osoblje> Delete(int id);
        public Task<Osoblje> Authenticiraj(string username, string pass);
        

    }
}
