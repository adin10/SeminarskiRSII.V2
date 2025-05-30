﻿using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface ICjenovnikService
    {
        public Task<List<Cjenovnik>> GetList(DateTime datumOd, DateTime datumDo, double? cijenaOd, double? cijenaDo, int? sprat);
        public Task<List<Cjenovnik>> getAllCijene();
        public Task<Cjenovnik> Get(int id);
        public Task<Cjenovnik> Insert(CijenaInsertRequest insert);
        public Task<Cjenovnik> Update(int id, CijenaInsertRequest update);
        public Task<Cjenovnik> Delete(int id);
    }
}
