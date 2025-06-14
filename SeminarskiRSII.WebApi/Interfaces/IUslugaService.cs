using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IUslugaService
    {
        public Task<List<Usluga>> GetList();
        public Task<Usluga> Insert(UslugaInsertRequest request);
        public Task<Usluga> Update(int id, UslugaInsertRequest request);
        public Task<Usluga> Delete(int id);

    }
}
