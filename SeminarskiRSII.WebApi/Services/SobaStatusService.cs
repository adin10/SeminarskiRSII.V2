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
    public class SobaStatusService:ISobaStatusService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public SobaStatusService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.SobaStatus> Delete(int id)
        {
            var entity =await _context.SobaStatus.FindAsync(id);
            _context.SobaStatus.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaStatus>(entity);
        }

        public async Task<List<Model.Models.SobaStatus>> GetList()
        {
            var list = await _context.SobaStatus.ToListAsync();
            return _mapper.Map<List<Model.Models.SobaStatus>>(list);
        }

        public async Task<Model.Models.SobaStatus> Get(int id)
        {
            var entitiy = await _context.SobaStatus.FindAsync(id);
            return _mapper.Map<Model.Models.SobaStatus>(entitiy);
        }

        public async Task<Model.Models.SobaStatus> Insert(SobaStatusInsertRequest insert)
        {
            var entity = _mapper.Map<SobaStatus>(insert);
            await _context.SobaStatus.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaStatus>(entity);
        }

        public async Task<Model.Models.SobaStatus> Update(int id, SobaStatusInsertRequest update)
        {
            var entity = await _context.SobaStatus.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.SobaStatus>(entity);
        }
    }
}
