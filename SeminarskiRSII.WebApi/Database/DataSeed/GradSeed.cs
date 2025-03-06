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
                    PostanskiBroj = 88000,
                    DrzavaId = 1
                },
                new Grad() 
                {
                    Id = 2,
                    NazivGrada = "Sarajevo",
                    PostanskiBroj = 71000,
                    DrzavaId = 1
                },
                new Grad()
                {
                    Id = 3,
                    NazivGrada = "Tuzla",
                    PostanskiBroj = 75000,
                    DrzavaId = 1
                },
                new Grad()
                {
                    Id = 4,
                    NazivGrada = "Zagreb",
                    PostanskiBroj = 44000,
                    DrzavaId = 2
                },
                new Grad()
                {
                    Id = 5,
                    NazivGrada = "Beograd",
                    PostanskiBroj = 49000,
                    DrzavaId = 3
                },
                new Grad()
                {
                    Id = 6,
                    NazivGrada = "Bihac",
                    PostanskiBroj = 77000,
                    DrzavaId = 1
                }
            });
            modelBuilder.Entity<Grad>().HasData(list);
        }
    }
}
