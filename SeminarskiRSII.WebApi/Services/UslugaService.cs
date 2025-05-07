using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebApi.Mappers;

namespace SeminarskiRSII.WebApi.Services
{
    public class UslugaService : IUslugaService
    {
        private readonly IMapper _mapper;
        private readonly IB210330Context _context;

        public UslugaService(IMapper mapper, IB210330Context context)
        {
            _mapper = mapper;
            _context = context;
        }

        public async Task<List<Model.Models.Usluga>> GetList()
        {
            var uslugaList = await _context.Usluga.ToListAsync();
            return _mapper.Map<List<Model.Models.Usluga>> (uslugaList);
        }

        public async Task<Model.Models.Usluga> Insert(UslugaInsertRequest request)
        {
            var entity = _mapper.Map<Database.Usluga>(request);
            await _context.Usluga.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Usluga>(entity);
        }

        public async Task<Model.Models.Usluga> Delete(int id)
        {
            var usluga = await _context.Usluga.FirstOrDefaultAsync(x => x.UslugaID == id);
            _context.Usluga.Remove(usluga);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Usluga>(usluga);
        }
    }
}
