using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class RecenzijaSeed
    {
        public static void SeedRecenzija(this ModelBuilder modelBuilder)
        {
            List<Recenzija> list = new List<Recenzija>();
            list.AddRange(new List<Recenzija>()
            {
                new Recenzija()
                {
                    Id = 1,
                    GostId = 1,
                    SobaId = 1,
                    Ocjena = 10,
                    Komentar = "Prezadovoljan hotelom i uslugom",
                    //DatumRecenzije = new DateTime(2025, 01, 01),
                },
                new Recenzija()
                {
                    Id = 2,
                    GostId = 2,
                    SobaId = 2,
                    Ocjena = 8,
                    Komentar = "Hrana nije bila bas najbolja",
                    //DatumRecenzije = new DateTime(2025, 04, 04),
                },
                new Recenzija()
                {
                    Id = 3,
                    GostId = 3,
                    SobaId = 2,
                    Ocjena = 9,
                    Komentar = "Sve preporuke za ovaj hotel",
                    //DatumRecenzije = new DateTime(2025, 05, 05),
                },
                new Recenzija()
                {
                    Id = 4,
                    GostId = 4,
                    SobaId = 3,
                    Ocjena = 10,
                    Komentar = "Prezadovoljan sa svim",
                    //DatumRecenzije = new DateTime(2025, 02, 03),
                }
            });
            modelBuilder.Entity<Recenzija>().HasData(list);
        }
    }
}
