using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class RezervacijaUslugaSeed
    {
        public static void SeedRezervacijaUsluga(this ModelBuilder modelBuilder)
        {
            List<RezervacijaUsluga> list = new List<RezervacijaUsluga>();
            list.AddRange(new List<RezervacijaUsluga>()
            {
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 1,
                    RezervacijaID = 1,
                    UslugaId = 1,
                },
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 2,
                    RezervacijaID = 1,
                    UslugaId = 2,
                },
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 3,
                    RezervacijaID = 1,
                    UslugaId = 4,
                },
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 4,
                    RezervacijaID = 2,
                    UslugaId = 3,
                },
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 5,
                    RezervacijaID = 3,
                    UslugaId = 4,
                },
                new RezervacijaUsluga()
                {
                    RezervacijaUslugaID = 6,
                    RezervacijaID = 3,
                    UslugaId = 2,
                }
            });
            modelBuilder.Entity<RezervacijaUsluga>().HasData(list);
        }
    }
}
