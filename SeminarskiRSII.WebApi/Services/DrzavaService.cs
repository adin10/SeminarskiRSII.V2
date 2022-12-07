using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Services
{
    public class DrzavaService : IDrzavaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        public DrzavaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Drzava> Get(int id)
        {
            var entity =await _context.Drzava.FirstOrDefaultAsync(x =>x.Id == id) ;
            return _mapper.Map<Model.Models.Drzava>(entity);
        }

        public async Task<List<Model.Models.Drzava>> GetList(DrzavaSearchRequest request)
        {
            var query = _context.Drzava.AsQueryable();
            if (!string.IsNullOrWhiteSpace(request?.naziv))
            {
                var normalizedName = request.naziv.ToLower();
                query = query.Where(x => x.Naziv.ToLower().Contains(normalizedName));
            }
            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Drzava>>(list);
        }

        public async Task<Model.Models.Drzava> Insert(DrzavaInsertRequest request)
        {
            var entity = _mapper.Map<Database.Drzava>(request);
           await _context.Drzava.AddAsync(entity);
           await _context.SaveChangesAsync();
           return _mapper.Map<Model.Models.Drzava>(entity);
        }

        public async Task<Model.Models.Drzava> Update(int id, DrzavaInsertRequest requets)
        {
            var entity = await _context.Drzava.FindAsync(id);
            _mapper.Map(requets, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Drzava>(entity);
        }
    }
}
