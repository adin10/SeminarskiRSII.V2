using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IGradService
    {
        public Task<List<Grad>> GetList(GradSearchRequest request);
        public Task<Grad> Get(int id);
        public Task<Grad> Insert(GradInsertRequest request);
        public Task<Grad> Update(int id, GradInsertRequest update);
        public Task<Grad> Delete(int id);
    }
}
