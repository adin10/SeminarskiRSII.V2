using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class SobaOsobljeSeed
    {
        public static void SeedSobaOsoblje(this ModelBuilder modelBuilder)
        {
            List<SobaOsoblje> list = new List<SobaOsoblje>();
            list.AddRange(new List<SobaOsoblje>()
            {
                new SobaOsoblje()
                {
                    Id = 1,
                    SobaId = 1,
                    OsobljeId = 4
                },
                new SobaOsoblje()
                {
                    Id = 2,
                    SobaId = 2,
                    OsobljeId = 4
                },
                new SobaOsoblje()
                {
                    Id = 3,
                    SobaId = 3,
                    OsobljeId = 4
                },
                new SobaOsoblje()
                {
                    Id = 4,
                    SobaId = 4,
                    OsobljeId = 4
                }
            });
            modelBuilder.Entity<SobaOsoblje>().HasData(list);
        }
    }
}
