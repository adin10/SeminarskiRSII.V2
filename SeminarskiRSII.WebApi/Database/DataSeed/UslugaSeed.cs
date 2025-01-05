using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class UslugaSeed
    {
        public static void SeedUsluga(this ModelBuilder modelBuilder)
        {
            List<Usluga> list = new List<Usluga>();
            list.AddRange(new List<Usluga>()
            {
                new Usluga()
                {
                    UslugaID = 1,
                    Naziv = "Dorucak",
                    Opis = "Dorucak u hotelu",
                    Cijena = 10
                },
                new Usluga()
                {
                    UslugaID = 2,
                    Naziv = "Rucak",
                    Opis = "Rucak u hotelu",
                    Cijena = 15
                },
                new Usluga()
                {
                    UslugaID = 3,
                    Naziv = "Masaza",
                    Opis = "Usluge masaze",
                    Cijena = 50
                },
                new Usluga()
                {
                    UslugaID = 4,
                    Naziv = "Sauna",
                    Opis = "Koristenje saune",
                    Cijena = 75
                }
            });
            modelBuilder.Entity<Usluga>().HasData(list);
        }
    }
}
