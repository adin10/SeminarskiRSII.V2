using AutoMapper;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Services
{
    public class SobaOsobljeService:ISobaOsobljeService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public SobaOsobljeService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.SobaOsoblje> Delete(int id)
        {
            var entity = await _context.SobaOsoblje.FindAsync(id);
            _context.SobaOsoblje.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaOsoblje>(entity);
        }

        public async Task<List<Model.Models.SobaOsoblje>> GetList()
        {
            var list = await _context.SobaOsoblje.Include(s => s.Soba).Include(o => o.Osoblje).ToListAsync();
            return _mapper.Map<List<Model.Models.SobaOsoblje>>(list);
        }

        public async Task<Model.Models.SobaOsoblje> Get(int id)
        {
            var entity = await _context.SobaOsoblje.Include(s=>s.Soba).Include(s=>s.Osoblje).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.SobaOsoblje>(entity);
        }

        public async Task<Model.Models.SobaOsoblje> Insert(SobaOsobljeInsertRequest insert)
        {
            var entity = _mapper.Map<Database.SobaOsoblje>(insert);
            await _context.SobaOsoblje.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaOsoblje>(entity);
        }

        public async Task<Model.Models.SobaOsoblje> Update(int id, SobaOsobljeInsertRequest insert)
        {
            var entity = await _context.SobaOsoblje.FindAsync(id);
            _mapper.Map(insert, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaOsoblje>(entity);
        }
    }
}
