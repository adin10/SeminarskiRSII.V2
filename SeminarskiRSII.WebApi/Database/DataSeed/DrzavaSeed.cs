using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class DrzavaSeed
    {
        public static void SeedDrzava(this ModelBuilder modelBuilder)
        {
            List<Drzava> list = new List<Drzava>();
            list.AddRange(new List<Drzava>()
            {
                new Drzava()
                {
                    Id = 1,
                    Naziv = "Bosna i Hercegovina"
                },
                new Drzava()
                {
                    Id = 2,
                    Naziv = "Hrvatska"
                },
                new Drzava()
                {
                    Id = 3,
                    Naziv = "Srbija"
                }
            });
            modelBuilder.Entity<Drzava>().HasData(list);
        }
    }
}
