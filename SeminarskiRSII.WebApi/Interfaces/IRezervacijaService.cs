using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface IRezervacijaService
    {
        public Task<List<Rezervacija>> GetList(RezervacijaSearchRequest search);
        public Task<Rezervacija> Get(int id);
        public Task<Rezervacija> Insert(RezervacijaInsertRequest insert);
        public Task<Rezervacija> Update(int id, RezervacijaInsertRequest update);
        public Task<Rezervacija> Delete(int id);
        public Task<float> CalculateTotalPrice(int sobaId, DateTime startDate, DateTime endDate, List<int> uslugaIds);
    }
}
