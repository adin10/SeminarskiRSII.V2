using AutoMapper;
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

        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;
        public List<Model.Models.Rezervacija> Recommend(int gostID)
        {
            if (mlContext == null)
            {
                mlContext = new MLContext();

                var tmpData = _context.Rezervacija.Include(x => x.Soba)
                   .GroupBy(x => x.SobaId)
                   .Select(x => x.Select(y => new Database.Rezervacija
                   {
                       SobaId = y.SobaId,
                       GostId = y.GostId
                   })).ToList();

                var data = new List<RezervacijaEntry>();
                foreach (var item in tmpData)
                {
                    if (item.Count() > 1)
                    {

                        var distinctItemId = item.Select(y => y.SobaId).ToList();

                        distinctItemId.ForEach(y =>
                        {
                                data.Add(new RezervacijaEntry()
                                {
                                    SobaID = (uint)y,
                                    CoPurchaseProductID = (uint)y
                                });
                        });
                    }
                }

                var trainData = mlContext.Data.LoadFromEnumerable(data);

                //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
                //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(RezervacijaEntry.SobaID);
                options.MatrixRowIndexColumnName = nameof(RezervacijaEntry.CoPurchaseProductID);
                options.LabelColumnName = "Label";
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                options.C = 0.00001;

                var trainer = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                model = trainer.Fit(trainData);
            }

            var elements = _context.Rezervacija.Where(x => x.GostId != gostID).ToList();
            var allItems = elements.GroupBy(x => x.SobaId).Select(y=>y.First()).ToList();

            var predictionResult = new List<Tuple<Rezervacija, float>>();

            foreach (var item in allItems)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<RezervacijaEntry, Copurchase_prediction>(model);
                var prediction = predictionEngine.Predict(new RezervacijaEntry()
                {
                    //MaterialID = (uint)materialId,
                    CoPurchaseProductID = (uint)item.SobaId
                });

                predictionResult.Add(new Tuple<Rezervacija, float>(item, prediction.Score));
            }
            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
               .Select(x => x.Item1).Take(3).ToList();
            var mapperList = _mapper.Map<List<Model.Models.Rezervacija>>(finalResult);
            return mapperList;
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
