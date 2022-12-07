using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface ISobaStatusService
    {
        public Task<List<SobaStatus>> GetList();
        public Task<SobaStatus> Get(int id);
        public Task<SobaStatus> Insert(SobaStatusInsertRequest insert);
        public Task<SobaStatus> Update(int id, SobaStatusInsertRequest update);
        public Task<SobaStatus> Delete(int id);
    }
}
