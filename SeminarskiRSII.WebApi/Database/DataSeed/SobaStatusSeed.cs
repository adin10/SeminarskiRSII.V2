using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class SobaStatusSeed
    {
        public static void SeedSobaStatus(this ModelBuilder modelBuilder)
        {
            List<SobaStatus> list = new List<SobaStatus>();
            list.AddRange(new List<SobaStatus>()
            {
                new SobaStatus()
                {
                    Id = 1,
                    Status = "Slobodna",
                    Opis = "Soba Slobodna za rezervisanje"
                },
                new SobaStatus() 
                {
                    Id = 2,
                    Status = "Zauzeta",
                    Opis = "Soba trenutacno zauzeta"
                }
            });
            modelBuilder.Entity<SobaStatus>().HasData(list);
        }
    }
}
