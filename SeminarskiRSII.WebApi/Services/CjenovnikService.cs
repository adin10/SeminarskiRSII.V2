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
        //    var list = await _context.Cjenovnik
        //        .Include(c => c.Soba)
        //        .Where(c => !_context.Rezervacija.Any(r =>
        //            r.SobaId == c.SobaId &&
        //            r.DatumRezervacije < datumDo &&
        //            r.ZavrsetakRezervacije > datumOd
        //        )).ToListAsync();

        //    var mapped = _mapper.Map<List<Model.Models.Cjenovnik>>(list);

        //    var sveRecenzije = await _context.Recenzija.ToListAsync();
        //    var ukupno = 0;
        //    foreach(var x in mapped)
        //    {
        //        foreach(var y in sveRecenzije)
        //        {
        //            if(x.SobaId == y.SobaId)
        //            {
        //                var suma = y.Ocjena;
        //                var brojac = 1;
        //                ukupno = suma / brojac;
        //            }
        //            x.Soba.ProsjecnaOcjena = ukupno;
        //        }
        //    }

        //    return mapped;
        //}

        public async Task<List<Model.Models.Cjenovnik>> GetList(DateTime datumOd, DateTime datumDo)
        {
            var zauzeteSobeIds = await _context.Rezervacija
                .Where(r => r.DatumRezervacije < datumDo && r.ZavrsetakRezervacije > datumOd)
                .Select(r => r.SobaId)
                .Distinct()
                .ToListAsync();

            var slobodneSobeCijene = await _context.Cjenovnik
                .Include(c => c.Soba)
                .Where(c => !zauzeteSobeIds.Contains(c.SobaId))
                .ToListAsync();

            var mapped = _mapper.Map<List<Model.Models.Cjenovnik>>(slobodneSobeCijene);

            var prosjecneOcjene = await _context.Recenzija
                .GroupBy(r => r.SobaId)
                .Select(g => new {
                    SobaId = g.Key,
                    Prosjek = g.Average(r => r.Ocjena)
                })
                .ToDictionaryAsync(x => x.SobaId, x => x.Prosjek);

            foreach (var item in mapped)
            {
                if (prosjecneOcjene.TryGetValue(item.SobaId, out var prosjek))
                {
                    item.Soba.ProsjecnaOcjena = (float)prosjek;
                }
                else
                {
                    item.Soba.ProsjecnaOcjena = null;
                }
            }

            return mapped;
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
