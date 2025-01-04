using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.WebApiDodatni.Database;
using System;

namespace SeminarskiRSII.WebApiDodatni.Services
{
    public class RecenzijaService: IRecenzijaService
    {
        private IB210330Context _dbContext;
        private IMapper _mapper;
        public RecenzijaService(IB210330Context dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<List<Dtos.Recenzija>> GetTopRecenzije(int minOcjena)
        {
            var list = await _dbContext.Recenzija.Where(x=>x.Ocjena == minOcjena).ToListAsync();
            return _mapper.Map<List<Dtos.Recenzija>>(list);
        }
    }
}
