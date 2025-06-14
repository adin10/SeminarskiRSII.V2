using AutoMapper;
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
using SeminarskiRSII.Model.Models;

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
            var query = _context.Soba.AsQueryable();
            if (search != null)
            {
                if (search.BrojSobe.HasValue)
                {
                    query = query.Where(l => l.BrojSobe == search.BrojSobe.Value);
                }
                if (!string.IsNullOrWhiteSpace(search.SobaStatus))
                {
                    query = query.Where(x => x.StatusSobe.ToLower() == search.SobaStatus.ToLower());
                }
            }

            var list = await query.ToListAsync();
            var mapped = _mapper.Map<List<Model.Models.Soba>>(list);

            var cijene = await _context.Cjenovnik.ToListAsync();
            foreach(var x in mapped)
            {
                var cijena = cijene.FirstOrDefault(c => c.SobaId == x.Id);
                x.Cijena = cijena?.Cijena;
                x.Valuta = cijena?.Valuta;
                x.CijenaId = cijena?.Id;
            }
            return mapped;
        }

        public async Task<Model.Models.Soba> Get(int id)
        {
            var entity = await _context.Soba.FirstOrDefaultAsync(x => x.Id == id);
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Insert(SobaInsertRequest insert)
        {
            var listaSoba = await _context.Soba.ToListAsync();
            if (listaSoba.Any(x => x.BrojSobe == insert.BrojSobe))
            {
                return null;
            }

            var entity = _mapper.Map<Database.Soba>(insert);
            await _context.Soba.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Soba>(entity);
        }

        public async Task<Model.Models.Soba> Update(int id, SobaInsertRequest update)
        {
            var listaSoba = await _context.Soba.ToListAsync();
            if(listaSoba.Any(x=>x.BrojSobe == update.BrojSobe && x.Id != id))
            {
                return null;
            }
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

                var zadnjaGodina = DateTime.Now.AddDays(-365);
                var brojRezervacijaZadnjaGodina = _context.Rezervacija
                        .Count(r => r.SobaId == item.Id && r.DatumRezervacije >= zadnjaGodina);
                item.BrojRezervacijaUZadnjuGodinu = brojRezervacijaZadnjaGodina;
                predictionResult.Add(new Tuple<Model.Models.Soba, float>(item, prediction.Score * brojRezervacijaZadnjaGodina)); // Povećavamo relevantnost prema broju rezervacija
            }

            var finalResult = predictionResult
                .OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            return finalResult;
        }

        public async Task<bool> SobaZauzeta(int id)
        {
            var sobaId = await _context.Soba.FirstOrDefaultAsync(x=>x.Id == id);
            var sobaIdRezervacije = await _context.Rezervacija.Where(x=>x.SobaId == id).ToListAsync();
            foreach(var x in sobaIdRezervacije)
            {
                if(DateTime.Today >= x.DatumRezervacije && DateTime.Today <= x.ZavrsetakRezervacije)
                {
                    return true;
                }
                if (DateTime.Today == x.DatumRezervacije || DateTime.Today == x.ZavrsetakRezervacije)
                {
                    return true;
                }
            }
            return false;
        }

        public async Task<SobaIzvjestaj> GetSobaIzvjestaj(int id)
        {
            var soba = await _context.Soba.FindAsync(id);
            if (soba == null)
                return null;

            var rezervacije = await _context.Rezervacija
                .Where(r => r.SobaId == id)
                .Include(r => r.Gost)
                .Include(r => r.RezervacijaUsluge)
                    .ThenInclude(ru => ru.Usluga)
                .ToListAsync();

            var result = new SobaIzvjestaj
            {
                BrojSobe = soba.BrojSobe,
                BrojSprata = soba.BrojSprata,
                OpisSobe = soba.OpisSobe,
                Slika = soba.Slika,
                Rezervacije = rezervacije.Select(r => new RezervacijaZaSobuInfo
                {
                    DatumRezervacije = r.DatumRezervacije,
                    ZavrsetakRezervacije = r.ZavrsetakRezervacije,
                    GostIme = r.Gost?.Ime ?? "Nepoznato",
                    GostPrezime = r.Gost?.Prezime ?? "",
                    Cijena = r.Cijena,
                    Usluge = r.RezervacijaUsluge?.Select(ru => new UslugaSobaInfo
                    {
                        Naziv = ru.Usluga.Naziv,
                        Opis = ru.Usluga.Opis,
                        Cijena = ru.Usluga.Cijena
                    }).ToList() ?? new List<UslugaSobaInfo>()
                }).ToList()
            };

            return result;
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

