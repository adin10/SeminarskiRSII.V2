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
    public class SobaService : ISobaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public SobaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Soba> Delete(int id)
        {
            var entity = await _context.Soba.FindAsync(id);
            _context.Soba.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<List<Model.Models.Soba>> GetList(SobaSearchRequest search)
        {
            var query = _context.Soba.Include(s => s.SobaStatus).AsQueryable();
            if (search != null)
            {
                if (search.SobaStatusId.HasValue)
                {
                    query = query.Where(s => s.SobaStatusId == search.SobaStatusId.Value);
                }

                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(l => l.BrojSobe == search.BrojSobe.Value);
                }

            }

            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Soba>>(list);
        }

        public async Task<Model.Models.Soba> Get(int id)
        {
            var entity = await _context.Soba.Include(x=>x.SobaStatus).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Insert(SobaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Soba>(insert);
            await _context.Soba.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Update(int id, SobaInsertRequest update)
        {
            var entity = await _context.Soba.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

    }
    //public class SobaService : BaseCRUDService<Model.Soba, SobaSearchRequest,Database.Soba, SobaInsertRequest, SobaInsertRequest>
    //{
    //    public SobaService(HotelProbaContext context, IMapper mapper) : base(context, mapper)
    //    {
    //    }
    //    public override List<Model.Soba> get(SobaSearchRequest search)
    //    {
    //        var query = _context.Set<Database.Soba>().AsQueryable();
    //        if (search != null)
    //        {
    //            //if (search.SobaStatusId.HasValue)
    //            //{
    //            //    query = query.Where(s => s.SobaStatusId == search.SobaStatusId.Value);
    //            //}

    //            if (search.BrojSobe.HasValue)
    //            {
    //                query = query.Where(l => l.BrojSobe == search.BrojSobe.Value);
    //            }

    //        }

    //        var list = query.ToList();
    //        return _mapper.Map<List<Model.Soba>>(list);
    //    }
    //}
}

