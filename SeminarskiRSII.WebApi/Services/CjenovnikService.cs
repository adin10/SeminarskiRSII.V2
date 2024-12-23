using AutoMapper;
using SeminarskiRSII.Model.Requests;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Services
{
    public class CjenovnikService:ICjenovnikService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public CjenovnikService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Cjenovnik> Delete(int id)
        {
            var entity = await _context.Cjenovnik.FindAsync(id);
            _context.Cjenovnik.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<List<Model.Models.Cjenovnik>> GetList()
        {
            var list = await _context.Cjenovnik.Include(s => s.Soba).ThenInclude(s=>s.SobaStatus).Where(s=>s.Soba.SobaStatus.Status == "Slobodna").ToListAsync();
            return _mapper.Map<List<Model.Models.Cjenovnik>>(list);
        }

        public async Task<Model.Models.Cjenovnik> Get(int id)
        {
            var entity = await _context.Cjenovnik.Include(s=>s.Soba).ThenInclude(s=>s.SobaStatus).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<Model.Models.Cjenovnik> Insert(CijenaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Cjenovnik>(insert);
            await _context.Cjenovnik.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<Model.Models.Cjenovnik> Update(int id, CijenaInsertRequest update)
        {
            var entity = await _context.Cjenovnik.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }
    }
}
