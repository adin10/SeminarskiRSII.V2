using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IVrstaOsobljaService
    {
       public Task<List<VrstaOsoblja>> GetList();
       public Task<VrstaOsoblja> Get(int id);
        public Task<VrstaOsoblja> Insert(VrstaOsobljaInsertRequest insert);
        public Task<VrstaOsoblja> Update(int id, VrstaOsobljaInsertRequest update);
        public Task<VrstaOsoblja> Delete(int id);
    }
}
