﻿using AutoMapper;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;
using Microsoft.ML;
using SeminarskiRSII.Model.ML;
using Microsoft.ML.Trainers;

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
            var usluge = await _context.RezervacijaUsluga.Where(x => x.RezervacijaID == id).ToListAsync();
            foreach(var x in usluge)
            {
                _context.RezervacijaUsluga.Remove(x);
                await _context.SaveChangesAsync();
            }
            var entity = await _context.Rezervacija.FindAsync(id);
            _context.Rezervacija.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        public async Task<List<Model.Models.Rezervacija>> GetList(RezervacijaSearchRequest search)
        {
            var query = _context.Rezervacija.Include(r => r.Gost).Include(r => r.Soba).Include(r=>r.RezervacijaUsluge).ThenInclude(r=>r.Usluga).AsQueryable();
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
                query = query.Where(x => x.Gost.KorisnickoIme.ToLower().Contains(search.KorisnickoIme.ToLower()));
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
            float totalPrice = await CalculateTotalPrice(insert.SobaId.Value, insert.DatumRezervacije, insert.ZavrsetakRezervacije, insert.UslugaIds);

            var entity = _mapper.Map<Database.Rezervacija>(insert);
            entity.Cijena = totalPrice;

            await _context.Rezervacija.AddAsync(entity);
            await _context.SaveChangesAsync();

            // Handle UslugaIds
            if (insert.UslugaIds != null && insert.UslugaIds.Any())
            {
                var rezervacijaUsluge = insert.UslugaIds.Select(uslugaId => new RezervacijaUsluga
                {
                    RezervacijaID = entity.Id,
                    UslugaId = uslugaId
                }).ToList();

                await _context.RezervacijaUsluga.AddRangeAsync(rezervacijaUsluge);
                await _context.SaveChangesAsync();
            }

            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        public async Task<Model.Models.Rezervacija> Update(int id, RezervacijaInsertRequest update)
        {
            var entity = await _context.Rezervacija.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Rezervacija>(entity);
        }

        private async Task<float> CalculateTotalPrice(int sobaId, DateTime startDate, DateTime endDate, List<int> uslugaIds)
        {
            int brojDana = (endDate - startDate).Days;

            var cjenovnik = await _context.Cjenovnik
                .Where(c => c.SobaId == sobaId)
                .FirstOrDefaultAsync();

            if (cjenovnik == null)
            {
                throw new Exception("Cjenovnik entry not found for the specified Soba and number of days.");
            }

            float totalRoomPrice = cjenovnik.Cijena * brojDana;

            float totalServicePrice = 0;
            if (uslugaIds != null && uslugaIds.Any())
            {
                totalServicePrice = await _context.Usluga
                    .Where(u => uslugaIds.Contains(u.UslugaID))
                    .SumAsync(u => u.Cijena);
            }

            return totalRoomPrice + (totalServicePrice * brojDana);
        }
    }
}
