using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IDrzavaService
    {
        public Task<List<Drzava>> GetList(DrzavaSearchRequest request);
        public Task<Drzava> Get(int id);
        public Task<Drzava> Insert(DrzavaInsertRequest request);
        public Task<Drzava> Update(int id, DrzavaInsertRequest requets);
    }
}
