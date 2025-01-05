using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class OsobljeSeed
    {
        public static void SeedOsoblje(this ModelBuilder modelBuilder)
        {
            List<Osoblje> osoblje = new List<Osoblje>()
            {
                new Osoblje()
                {
                    Id = 1,
                    Ime = "adiiiin",
                    Prezime = "smaajkic",
                    Email= "adin.smajkic@gmail.com",
                    KorisnickoIme = "adin1998",
                    LozinkaHash = "XsHiRH3wqycFCD4pG26l5xPqJgo=",
                    LozinkaSalt = "FnmwHukhLVZJJLzL2Jg8HQ==",
                    Telefon = "061981256",
                    Slika = Convert.FromBase64String("")
                },
                new Osoblje()
                {
                    Id = 2,
                    Ime = "Haris",
                    Prezime = "Tulic",
                    Email= "haris.tulic@edu.fit.ba",
                    KorisnickoIme = "tulatula",
                    LozinkaHash = "RLkYnZGEW+Otmx0Kn78tQmSLxgk=",
                    LozinkaSalt = "A3bYgzz6F0Yvq/9KStj2oQ==",
                    Telefon = "0620626",
                    Slika = Convert.FromBase64String("")
                },
                new Osoblje()
                {
                    Id = 3,
                    Ime = "Dina",
                    Prezime = "Bjelic",
                    Email= "dina.bjelic@gmail.com",
                    KorisnickoIme = "dina99",
                    LozinkaHash = "XsHiRH3wqycFCD4pG26l5xPqJgo=",
                    LozinkaSalt = "A3bYgzz6F0Yvq/9KStj2oQ==",
                    Telefon = "062897542",
                    Slika = Convert.FromBase64String("")
                },
                new Osoblje()
                {
                    Id = 4,
                    Ime = "Smajo",
                    Prezime = "Durakovic",
                    Email= "smajo.durakovic@gmail.com",
                    KorisnickoIme = "smajo95",
                    LozinkaHash = "RLkYnZGEW+Otmx0Kn78tQmSLxgk=",
                    LozinkaSalt = "A3bYgzz6F0Yvq/9KStj2oQ==",
                    Telefon = "525521215",
                    Slika = Convert.FromBase64String("")
                }
            };
            modelBuilder.Entity<Osoblje>().HasData(osoblje);
        }
    }
}

