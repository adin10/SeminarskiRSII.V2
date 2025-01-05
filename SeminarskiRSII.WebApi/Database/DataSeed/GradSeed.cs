using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.Model.Models;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class GradSeed
    {
        public static void SeedGrad(this ModelBuilder modelBuilder)
        {
            List<Grad> list = new List<Grad>();
            list.AddRange(new List<Grad>()
            {
                new Grad()
                {
                    Id = 1,
                    NazivGrada = "Mostar",
                    DrzavaId = 1
                },
                new Grad() 
                {
                    Id = 2,
                    NazivGrada = "Sarajevo",
                    DrzavaId = 1
                },
                new Grad()
                {
                    Id = 3,
                    NazivGrada = "Tuzla",
                    DrzavaId = 1
                },
                new Grad()
                {
                    Id = 4,
                    NazivGrada = "Zagreb",
                    DrzavaId = 2
                },
                new Grad()
                {
                    Id = 5,
                    NazivGrada = "Beograd",
                    DrzavaId = 3
                },
                new Grad()
                {
                    Id = 6,
                    NazivGrada = "Bihac",
                    DrzavaId = 1
                }
            });
            modelBuilder.Entity<Grad>().HasData(list);
        }
    }
}
