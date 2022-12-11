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
    public class RezervacijaService:IRezervacijaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public RezervacijaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Rezervacija> Delete(int id)
        {
            var entity = await _context.Rezervacija.FindAsync(id);
            _context.Rezervacija.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        public async Task<List<Model.Models.Rezervacija>> GetList(RezervacijaSearchRequest search)
        {

            var query = _context.Rezervacija.Include(r => r.Gost).Include(r => r.Soba).AsQueryable();
            if (search != null)
            {
                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(r => r.Soba.BrojSobe == search.BrojSobe.Value);
                }
                if (search.gostID.HasValue)
                {
                    query = query.Where(r => r.GostId == search.gostID);
                }
            }
            if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
            {
                query = query.Where(x => x.Gost.KorisnickoIme.Contains(search.KorisnickoIme));
            }
            var list =await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Rezervacija>>(list);
        }

        public async Task<Model.Models.Rezervacija> Get(int id)
        {
            var entity = await _context.Rezervacija.Include(r => r.Gost).Include(r => r.Soba).FirstOrDefaultAsync(x=>x.Id ==id);
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        public async Task<Model.Models.Rezervacija> Insert(RezervacijaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Rezervacija>(insert);
            await _context.Rezervacija.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        public async Task<Model.Models.Rezervacija> Update(int id, RezervacijaInsertRequest update)
        {
            var entity = await _context.Rezervacija.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }
    }
}
