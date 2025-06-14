﻿using Microsoft.EntityFrameworkCore;

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
                    Valuta = "KM",
                    VrijediOd = new DateTime(2025, 01, 01),
                    VrijediDo = new DateTime(2025, 12, 31)
                },
                new Cjenovnik()
                {
                    Id = 2,
                    SobaId = 2,
                    Cijena = 150,
                    Valuta = "KM",
                    VrijediOd = new DateTime(2025, 01, 01),
                    VrijediDo = new DateTime(2025, 06, 30)
                },
                new Cjenovnik()
                {
                    Id = 3,
                    SobaId = 3,
                    Cijena = 100,
                    Valuta = "KM",
                    VrijediOd = new DateTime(2025, 06, 30),
                    VrijediDo = new DateTime(2025, 12, 31)
                },
                new Cjenovnik()
                {
                    Id = 4,
                    SobaId = 4,
                    Cijena = 120,
                    Valuta = "KM",
                    VrijediOd = new DateTime(2025, 06, 30),
                    VrijediDo = new DateTime(2025, 09, 30)
                },
                new Cjenovnik()
                {
                    Id = 5,
                    SobaId = 5,
                    Cijena = 80,
                    Valuta = "KM",
                    VrijediOd = new DateTime(2025, 02, 25),
                    VrijediDo = new DateTime(2025, 06, 26)
                }
            });
            modelBuilder.Entity<Cjenovnik>().HasData(list);
        }
    }
}
