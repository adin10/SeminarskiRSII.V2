using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface IRecenzijaService
    {
        public Task<List<Recenzija>> GetList(RecenzijaSearchRequest search);
        public Task<List<Recenzija>> GetListBySobaId(int sobaId);
        public Task<Recenzija> Get(int id);
        public Task<Recenzija> Insert(int rezervacijaId, RecenzijaInsertRequest insert);
        public Task<Recenzija> Update(int id, RecenzijaInsertRequest update);
        public Task<Recenzija> ObrisiKomentar(int id);
        
    }
}
