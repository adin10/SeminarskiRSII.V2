﻿using AutoMapper;
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
                if (search.ocjena.HasValue)
                {
                    query = query.Where(r => r.Ocjena == search.ocjena.Value);
                }
                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(r => r.Soba.BrojSobe == search.BrojSobe.Value);
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
    }
}
