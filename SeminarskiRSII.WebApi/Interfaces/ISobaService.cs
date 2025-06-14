using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface ISobaService
    {
        public Task<List<Soba>> GetList(SobaSearchRequest search);
        public Task<Soba> Get(int id);
        public Task<SobaIzvjestaj> GetSobaIzvjestaj(int id);
        public Task<Soba> Insert(SobaInsertRequest insert);
        public Task<Soba> Update(int id, SobaInsertRequest update);
        public Task<Soba> Delete(int id);
        public List<Soba> RecommendPopularRooms();
        public Task<bool> SobaZauzeta(int id);
        
    }
}
