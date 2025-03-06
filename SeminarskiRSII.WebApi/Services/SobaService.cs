﻿using AutoMapper;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using SeminarskiRSII.Model.ML;
using Microsoft.ML.Data;

namespace SeminarskiRSII.WebApi.Services
{
    public class SobaService : ISobaService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public SobaService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Soba> Delete(int id)
        {
            var entity = await _context.Soba.FindAsync(id);
            _context.Soba.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<List<Model.Models.Soba>> GetList(SobaSearchRequest search)
        {
            var query = _context.Soba.Include(s => s.SobaStatus).AsQueryable();
            if (search != null)
            {
                if (search.SobaStatusId.HasValue)
                {
                    query = query.Where(s => s.SobaStatusId == search.SobaStatusId.Value);
                }

                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(l => l.BrojSobe == search.BrojSobe.Value);
                }

            }

            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Soba>>(list);
        }

        public async Task<Model.Models.Soba> Get(int id)
        {
            var entity = await _context.Soba.Include(x => x.SobaStatus).FirstOrDefaultAsync(x => x.Id == id);
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Insert(SobaInsertRequest insert)
        {
            var entity = _mapper.Map<Database.Soba>(insert);
            await _context.Soba.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Update(int id, SobaInsertRequest update)
        {
            var entity = await _context.Soba.FindAsync(id);
            _mapper.Map(update, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        static ITransformer model = null;
        static MLContext mlContext = null;
        public List<Model.Models.Soba> RecommendPopularRooms()
        {
            if (mlContext == null)
            {
                mlContext = new MLContext();

                var reservations = _context.Rezervacija
                    .GroupBy(r => r.SobaId)
                    .Select(group => new RoomEntry
                    {
                        SobaID = (uint)group.Key,
                        Label = (float)group.Count()
                    })
                    .ToList();

                if (!reservations.Any())
                {
                    return Enumerable.Empty<Model.Models.Soba>().ToList();
                }

                var trainData = mlContext.Data.LoadFromEnumerable(reservations);

                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(RoomEntry.SobaID);
                options.MatrixRowIndexColumnName = nameof(RoomEntry.SobaID);
                options.LabelColumnName = nameof(RoomEntry.Label);
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                options.C = 0.00001;

                var trainer = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                model = trainer.Fit(trainData);
            }

            var allItems = _context.Soba.ToList();
            if (allItems == null)
            {
                return new List<Model.Models.Soba>();
            }

            var mappedRooms = _mapper.Map<List<Model.Models.Soba>>(allItems);

            if (model == null)
            {
                return Enumerable.Empty<Model.Models.Soba>().ToList();
            }

            var predictionResult = new List<Tuple<Model.Models.Soba, float>>();

            foreach (var item in mappedRooms)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<RoomEntry, RoomPrediction>(model);
                var prediction = predictionEngine.Predict(new RoomEntry()
                {
                    SobaID = (uint)item.Id
                });

                var reservationCount = _context.Rezervacija.Count(r => r.SobaId == item.Id);
                predictionResult.Add(new Tuple<Model.Models.Soba, float>(item, prediction.Score * reservationCount)); // Povećavamo relevantnost prema broju rezervacija
            }

            var finalResult = predictionResult
                .OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            return finalResult;
        }
    }

    public class RoomEntry
    {
        [KeyType(count:2000)]
        public uint SobaID { get; set; }
        [KeyType(count: 2000)]
        public uint SobaIDRelated { get; set; }
        public float Label { get; set; }
    }

    public class RoomPrediction
    {
        public float Score { get; set; }
    }
    //public class SobaService : BaseCRUDService<Model.Soba, SobaSearchRequest,Database.Soba, SobaInsertRequest, SobaInsertRequest>
    //{
    //    public SobaService(HotelProbaContext context, IMapper mapper) : base(context, mapper)
    //    {
    //    }
    //    public override List<Model.Soba> get(SobaSearchRequest search)
    //    {
    //        var query = _context.Set<Database.Soba>().AsQueryable();
    //        if (search != null)
    //        {
    //            //if (search.SobaStatusId.HasValue)
    //            //{
    //            //    query = query.Where(s => s.SobaStatusId == search.SobaStatusId.Value);
    //            //}

    //            if (search.BrojSobe.HasValue)
    //            {
    //                query = query.Where(l => l.BrojSobe == search.BrojSobe.Value);
    //            }

    //        }

    //        var list = query.ToList();
    //        return _mapper.Map<List<Model.Soba>>(list);
    //    }
    //}
}

