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
   
        public class NotifikacijaService : BaseCRUDService<Model.Models.Notifikacije, NotifikacijeSearchRequest, Database.Notifikacije, NotifikacijeInsertRequest, NotifikacijeInsertRequest>
        {
            public NotifikacijaService(IB210330Context context, IMapper mapper) : base(context, mapper)
            {
            }

            public override List<Model.Models.Notifikacije> get(NotifikacijeSearchRequest search)
            {
                var query = _context.Notifikacije.Include(x => x.Novost).AsQueryable();

                if (search != null)
                {
                    if (!string.IsNullOrWhiteSpace(search.Naslov))
                    {
                        query = query.Where(l => l.Naslov.StartsWith(search.Naslov));
                    }

                    if (search.NovostId.HasValue)
                    {
                        query = query.Where(l => l.NovostId == search.NovostId.Value);
                    }
                }

                var lista = query.OrderByDescending(l => l.DatumSlanja).ToList();

                return _mapper.Map<List<Model.Models.Notifikacije>>(lista);

         }
    }
 }

