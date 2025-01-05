using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class SobaSeed
    {
        public static void SeedSoba(this ModelBuilder modelBuilder)
        {
            List<Soba> list = new List<Soba>();
            list.AddRange(new List<Soba>()
            {
                new Soba()
                {
                    Id = 1,
                    BrojSobe = 1,
                    BrojSprata = 1,
                    OpisSobe = "Soba u tisini",
                    SobaStatusId = 1,
                    Slika = Convert.FromBase64String("")
                },
                new Soba()
                {
                    Id = 2,
                    BrojSobe = 2,
                    BrojSprata = 1,
                    OpisSobe = "Soba u tisini",
                    SobaStatusId = 1,
                    Slika = Convert.FromBase64String("")
                },
                new Soba()
                {
                    Id = 3,
                    BrojSobe = 3,
                    BrojSprata = 1,
                    OpisSobe = "Soba s pogledom na more",
                    SobaStatusId = 2,
                    Slika = Convert.FromBase64String("")
                },
                new Soba()
                {
                    Id = 4,
                    BrojSobe = 4,
                    BrojSprata = 2,
                    OpisSobe = "Soba s pogledom na cijeli grad",
                    SobaStatusId = 1,
                    Slika = Convert.FromBase64String("")
                }
            });
            modelBuilder.Entity<Soba>().HasData(list);
        }
    }
}
