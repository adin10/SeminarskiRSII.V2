using AutoMapper;
using SeminarskiRSII.Model;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
    public class GostiNotifikacijeService : IGostiNotifikacijeService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        public GostiNotifikacijeService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Model.Models.GostiNotifikacije>> GetList(GostiNotifikacijeSearchRequest search)
        {
            var query =  _context.GostiNotifikacije.Include(x => x.Gost).Include(l => l.Notifikacije).AsQueryable();

            if (search != null)
            {
                if (search.GostId.HasValue)
                {
                    query = query.Where(l => l.GostId == search.GostId.Value);
                }

                if (search.NotifikacijaId.HasValue)
                {
                    query = query.Where(l => l.NotifikacijeId == search.NotifikacijaId);
                }

            }

            var lista = await query.ToListAsync();

            return _mapper.Map<List<Model.Models.GostiNotifikacije>>(lista);
        }

    }

    //public class GostiNotifikacijeService : BaseCRUDService<Model.Models.GostiNotifikacije, GostiNotifikacijeSearchRequest, Database.GostiNotifikacije, GostiNotifikacijeInsertRequest, GostiNotifikacijeInsertRequest>
    //{
    //    public GostiNotifikacijeService(IB210330Context context, IMapper mapper) : base(context, mapper)
    //    {
    //    }

    //    public override List<Model.Models.GostiNotifikacije> get(GostiNotifikacijeSearchRequest search)
    //    {
    //        var query = _context.GostiNotifikacije.Include(x => x.Gost).Include(l => l.Notifikacije).AsQueryable();

    //        if (search != null)
    //        {
    //            if (search.GostId.HasValue)
    //            {
    //                query = query.Where(l => l.GostId == search.GostId.Value);
    //            }

    //            if (search.NotifikacijaId.HasValue)
    //            {
    //                query = query.Where(l => l.NotifikacijeId == search.NotifikacijaId.Value);
    //            }

    //        }

    //        var lista = query.ToList();

    //        return _mapper.Map<List<Model.Models.GostiNotifikacije>>(lista);
    //    }
    //}
}
