using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class RezervacijaSeed
    {
        public static void SeedRezervacija(this ModelBuilder modelBuilder)
        {
            List<Rezervacija> list = new List<Rezervacija>();
            list.AddRange(new List<Rezervacija>()
            {
                new Rezervacija()
                {
                    Id = 1,
                    GostId = 1,
                    SobaId = 1,
                    DatumRezervacije = new DateTime(2024, 12, 30),
                    ZavrsetakRezervacije = new DateTime(2025, 01, 01),
                    Cijena = 305
                },
                new Rezervacija()
                {
                    Id = 2,
                    GostId = 2,
                    SobaId = 1,
                    DatumRezervacije = new DateTime(2024, 12, 26),
                    ZavrsetakRezervacije = new DateTime(2024, 12, 29),
                    Cijena = 295
                },
                new Rezervacija()
                {
                    Id = 3,
                    GostId = 3,
                    SobaId = 2,
                    DatumRezervacije = new DateTime(2024, 12, 11),
                    ZavrsetakRezervacije = new DateTime(2024, 12, 14),
                    Cijena = 215
                },
                new Rezervacija()
                {
                    Id = 4,
                    GostId = 4,
                    SobaId = 3,
                    DatumRezervacije = new DateTime(2024, 12, 01),
                    ZavrsetakRezervacije = new DateTime(2024, 12, 04),
                    Cijena = 350
                }
            });
            modelBuilder.Entity<Rezervacija>().HasData(list);
        }
    }
}
