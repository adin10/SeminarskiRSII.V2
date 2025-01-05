using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class NovostiSeed
    {
        public static void SeedNovosti(this ModelBuilder modelBuilder)
        {
            List<Novosti> list = new List<Novosti>();
            list.AddRange(new List<Novosti>()
            {
                new Novosti()
                {
                    Id = 1,
                    Naslov = "Akcije za novu godinu",
                    Sadrzaj = "Docekajte novu godinu u nasem hotelu uz nikad povoljnije cijene",
                    DatumObjave = new DateTime(2024, 12, 20),
                    OsobljeId = 1
                },
                new Novosti()
                {
                    Id = 2,
                    Naslov = "Svi smjestajni kapaciteti popunjeni",
                    Sadrzaj = "Prethodni vikend, svi smjestajni kapaciteti bili popunjeni",
                    DatumObjave = new DateTime(2024, 12, 25),
                    OsobljeId = 4
                },
                new Novosti()
                {
                    Id = 3,
                    Naslov = "Posjeta hotelu",
                    Sadrzaj = "Nas hotel posjetila reprezentacija Bosne i Hercegovine",
                    DatumObjave = new DateTime(2024, 12, 30),
                    OsobljeId = 4
                }
            });
            modelBuilder.Entity<Novosti>().HasData(list);
        }
    }
}
