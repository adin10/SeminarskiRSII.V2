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
    public class RecenzijaService:IRecenzijaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public RecenzijaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Model.Models.Recenzija>> GetList(RecenzijaSearchRequest search)
        {
            var query = _context.Recenzija.Include(r => r.Gost).Include(r=>r.Soba).AsQueryable();
            if (search != null)
            {
                if (!string.IsNullOrWhiteSpace(search.ImePrezime))
                {
                    var imePrezime = search.ImePrezime.ToLower();
                    query = query.Where(x => x.Gost.Ime.ToLower().Contains(imePrezime) ||
                    x.Gost.Prezime.ToLower().Contains(imePrezime));
                }
                if (search.ocjena.HasValue)
                {
                    query = query.Where(r => r.Ocjena == search.ocjena);
                }
                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(r => r.Soba.BrojSobe == search.BrojSobe.Value);
                }
                if (search.sobaID.HasValue)
                {
                    query = query.Where(r => r.SobaId == search.sobaID);
                }
            }
            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Recenzija>>(list);
        }

        public async Task<Model.Models.Recenzija> Get(int id)
        {
            var entity = await _context.Recenzija.Include(x=>x.Soba).Include(x=>x.Gost).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.Recenzija>(entity);
        }

        public async Task<Model.Models.Recenzija> Insert(RecenzijaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Recenzija>(insert);
            await _context.Recenzija.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Recenzija>(entity);
        }

        public async Task<Model.Models.Recenzija> Update(int id, RecenzijaInsertRequest update)
        {
            var entity = await _context.Recenzija.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Recenzija>(entity);
        }

        public async Task<Model.Models.Recenzija> ObrisiKomentar(int id)
        {
            var recenzija = await _context.Recenzija.FirstOrDefaultAsync(x => x.Id == id);
            recenzija.Komentar = "";
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Recenzija>(recenzija);
        }
    }
}
