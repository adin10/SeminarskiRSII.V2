using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
    public class VrstaOsobljaService:IVrstaOsobljaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        public VrstaOsobljaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Model.Models.VrstaOsoblja>> GetList()
        {
            var list = await _context.VrstaOsoblja.ToListAsync();
            return _mapper.Map<List<Model.Models.VrstaOsoblja>>(list);
        }

        public async Task<Model.Models.VrstaOsoblja> Get(int id)
        {
            var entity = await _context.VrstaOsoblja.FindAsync(id);
            return _mapper.Map<Model.Models.VrstaOsoblja>(entity);
        }

        public async Task<Model.Models.VrstaOsoblja> Insert(VrstaOsobljaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.VrstaOsoblja>(insert);
            await _context.VrstaOsoblja.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.VrstaOsoblja>(entity);
        }

        public async Task<Model.Models.VrstaOsoblja> Update(int id, VrstaOsobljaInsertRequest update)
        {
            var entity = await _context.VrstaOsoblja.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.VrstaOsoblja>(entity);
        }

        public async Task<Model.Models.VrstaOsoblja> Delete(int id)
        {
            var entity = await _context.VrstaOsoblja.FindAsync(id);
            _context.VrstaOsoblja.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.VrstaOsoblja>(entity);
        }
    }
}
