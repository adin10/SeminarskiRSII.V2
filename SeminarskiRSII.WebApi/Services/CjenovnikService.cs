using AutoMapper;
using SeminarskiRSII.Model.Requests;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Services
{
    public class CjenovnikService:ICjenovnikService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public CjenovnikService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Cjenovnik> Delete(int id)
        {
            var entity = await _context.Cjenovnik.FindAsync(id);
            _context.Cjenovnik.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        //public async Task<List<Model.Models.Cjenovnik>> GetList(DateTime datumOd, DateTime datumDo)
        //{
        //    var list = await _context.Cjenovnik.Include(s => s.Soba).Where(c => !_context.Rezervacija.Any(r =>
        //                (datumOd >= r.DatumRezervacije && datumOd < r.ZavrsetakRezervacije) ||
        //                (datumDo > r.DatumRezervacije && datumDo <= r.ZavrsetakRezervacije) ||
        //                (datumOd <= r.DatumRezervacije && datumDo >= r.ZavrsetakRezervacije)
        //        ))
        //.ToListAsync();
        //    return _mapper.Map<List<Model.Models.Cjenovnik>>(list);
        //}

        public async Task<List<Model.Models.Cjenovnik>> GetList(DateTime datumOd, DateTime datumDo)
        {
            var list = await _context.Cjenovnik
                .Include(c => c.Soba)
                .Where(c => !_context.Rezervacija.Any(r =>
                    r.SobaId == c.SobaId &&
                    r.DatumRezervacije < datumDo &&
                    r.ZavrsetakRezervacije > datumOd
                ))
                .ToListAsync();

            return _mapper.Map<List<Model.Models.Cjenovnik>>(list);
        }

        public async Task<Model.Models.Cjenovnik> Get(int id)
        {
            var entity = await _context.Cjenovnik.Include(s=>s.Soba).FirstOrDefaultAsync(x=>x.Id == id);
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<Model.Models.Cjenovnik> Insert(CijenaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Cjenovnik>(insert);
            await _context.Cjenovnik.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<Model.Models.Cjenovnik> Update(int id, CijenaInsertRequest update)
        {
            var entity = await _context.Cjenovnik.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Cjenovnik>(entity);
        }

        public async Task<List<Model.Models.Cjenovnik>> getAllCijene()
        {
            var list = await _context.Cjenovnik.Include(s => s.Soba).ToListAsync();
            return _mapper.Map<List<Model.Models.Cjenovnik>>(list);
        }
    }
}
