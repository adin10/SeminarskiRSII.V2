using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class CjenovnikSeed
    {
        public static void SeedCjenovnik(this ModelBuilder modelBuilder)
        {
            List<Cjenovnik> list = new List<Cjenovnik>();
            list.AddRange(new List<Cjenovnik>()
            {
                new Cjenovnik()
                {
                    Id = 1,
                    SobaId = 1,
                    Cijena = 50,
                    Valuta = "KM"
                },
                new Cjenovnik()
                {
                    Id = 2,
                    SobaId = 2,
                    Cijena = 150,
                    Valuta = "KM"
                },
                new Cjenovnik()
                {
                    Id = 3,
                    SobaId = 3,
                    Cijena = 100,
                    Valuta = "KM"
                }
            });
            modelBuilder.Entity<Cjenovnik>().HasData(list);
        }
    }
}
