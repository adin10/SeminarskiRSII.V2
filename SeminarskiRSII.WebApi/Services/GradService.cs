using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Services
{
    public class GradService : IGradService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        public GradService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<Model.Models.Grad> Get(int id)
        {
            var entity = await _context.Grad.Include(x=>x.Drzava).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.Grad>(entity);
        }

        public async Task<List<Model.Models.Grad>> GetList(GradSearchRequest request)
        {
            var query = _context.Grad.Include(x=>x.Drzava).AsQueryable();
            if(request != null)
            {
                if (!string.IsNullOrWhiteSpace(request.NazivGrada))
                {
                    var normalizedName = request.NazivGrada.ToLower();
                    query = query.Where(x => x.NazivGrada.ToLower().Contains(normalizedName));
                }
                if (request.DrzavaId.HasValue)
                {
                    query = query.Where(x => x.DrzavaId == request.DrzavaId);
                }
            }
            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Grad>>(list);
        }

        public async Task<Model.Models.Grad> Insert(GradInsertRequest request)
        {
            var entity = _mapper.Map<Database.Grad>(request);
            await _context.Grad.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Grad>(entity);
        }

        public async Task<Model.Models.Grad> Update(int id, GradInsertRequest update)
        {
            var entity = await _context.Grad.FirstOrDefaultAsync(x => x.Id == id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Grad>(entity);
        }
    }
}
