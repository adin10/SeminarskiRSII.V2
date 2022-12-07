using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface ISobaOsobljeService
    {
        public Task<List<SobaOsoblje>> GetList();
        public Task<SobaOsoblje> Get(int id);
        public Task<SobaOsoblje> Insert(SobaOsobljeInsertRequest insert);
        public Task<SobaOsoblje> Update(int id, SobaOsobljeInsertRequest insert);
        public Task<SobaOsoblje> Delete(int id);
    }
}
