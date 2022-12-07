using AutoMapper;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
    public class NovostiService : BaseCRUDService<Model.Models.Novosti, NovostiSearchRequest, Database.Novosti, NovostiInsertRequest, NovostiInsertRequest>
    {
        public NovostiService(IB210330Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public override List<Model.Models.Novosti> get(NovostiSearchRequest search)
        {
            var query = _context.Novosti.Include(x => x.Osoblje).AsQueryable();

            if (search != null)
            {
                if (!string.IsNullOrWhiteSpace(search.Naslov))
                {
                    query = query.Where(l => l.Naslov.StartsWith(search.Naslov));
                }
                //search.DatumObjave = DateTime.Now;

                if (search.DatumObjave != null)
                {
                    query = query.Where(l => l.DatumObjave.Value.Date == search.DatumObjave.Value.Date);
                }
            }

            var lista = query.OrderByDescending(x => x.DatumObjave).ToList();

            return _mapper.Map<List<Model.Models.Novosti>>(lista);
        }
    }
}
