using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IGostService
    {
        public Task<List<Gost>> GetList(GostiSearchRequest search);
        public Task<Gost> Get(int id);
        public Task<Gost> Insert(GostiInsertRequest requst);
        public Task<Gost> Update(int id, GostiInsertRequest requst);
        public Task<Gost> Delete(int id);
        public Task<Gost> AuthenticirajGosta(string username, string pass);
        public Task<Gost> ChangePassword(int id, ChangePasswordRequest request);

    }
}
