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
    //public class NovostiService : BaseCRUDService<Model.Models.Novosti, NovostiSearchRequest, Database.Novosti, NovostiInsertRequest, NovostiInsertRequest>
    //{
    //    public NovostiService(IB210330Context context, IMapper mapper) : base(context, mapper)
    //    {
    //    }

    //    public override List<Model.Models.Novosti> get(NovostiSearchRequest search)
    //    {
    //        var query = _context.Novosti.Include(x => x.Osoblje).AsQueryable();

    //        if (search != null)
    //        {
    //            if (!string.IsNullOrWhiteSpace(search.Naslov))
    //            {
    //                query = query.Where(l => l.Naslov.StartsWith(search.Naslov));
    //            }
    //            //search.DatumObjave = DateTime.Now;

    //            if (search.DatumObjave != null)
    //            {
    //                query = query.Where(l => l.DatumObjave.Value.Date == search.DatumObjave.Value.Date);
    //            }
    //        }

    //        var lista = query.OrderByDescending(x => x.DatumObjave).ToList();

    //        return _mapper.Map<List<Model.Models.Novosti>>(lista);
    //    }
    //}

    public class NovostiService : INovostiService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        public NovostiService(IB210330Context context, IMapper mapper) {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Novosti> Get(int ID)
        {
            var entity = await _context.Novosti.Include(x=>x.Osoblje).FirstOrDefaultAsync(x => x.Id == ID);
            return _mapper.Map<Model.Models.Novosti>(entity);
        }

        public async Task<List<Model.Models.Novosti>> GetList(NovostiSearchRequest search)
        {
            var query = _context.Novosti.Include(x=>x.Osoblje).AsQueryable();
            if (search != null)
            {
                if (!string.IsNullOrWhiteSpace(search.Naslov))
                {
                    query = query.Where(x => x.Naslov.ToLower().Contains(search.Naslov.ToLower()));
                }
                if (!string.IsNullOrWhiteSpace(search.Sadrzaj))
                {
                    query = query.Where(x => x.Sadrzaj.ToLower().Contains(search.Sadrzaj.ToLower()));
                }
                if (search.DatumObjave.HasValue)
                {
                    query = query.Where(x => x.DatumObjave == search.DatumObjave);
                }
            }
            var list = await query.OrderByDescending(x=>x.DatumObjave).ToListAsync();
            return _mapper.Map<List<Model.Models.Novosti>>(list);
        }

        public async Task<Model.Models.Novosti> Insert(NovostiInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Novosti>(insert);
            await _context.Novosti.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Novosti>(entity);
        }

        public async Task<Model.Models.Novosti> Update(int ID, NovostiInsertRequest update)
        {
            var entity = await _context.Novosti.FindAsync(ID);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Novosti>(entity);
        }

        public async Task<Model.Models.Novosti> Delete(int id)
        {
            var entity = await _context.Novosti.FindAsync(id);
            _context.Novosti.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Novosti>(entity);
        }
    }
}
