using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class GostSeed
    {
        public static void SeedGost(this ModelBuilder modelBuilder)
        {
            List<Gost> gosti = new()
            {
                new Gost()
                {
                    Id = 1,
                    Ime = "Adin",
                    Prezime = "Smajkic",
                    Email = "adin.smajkic@gmail.com",
                    GradId = 1,
                    KorisnickoIme = "adin1998",
                    LozinkaHash = "ZG+m4HIibaJpXMVrtXhp9+QQiDE=",
                    LozinkaSalt = "8yGM2clNjUvFcuobbcqRSg==",
                    Telefon = "5842521",
                    DatumRegistracije = new DateTime(2025, 01, 01),
                    Status = true
                },
                new Gost()
                {
                    Id = 2,
                    Ime = "ahmed",
                    Prezime = "smajic",
                    Email = "ahmed.sm@gmail.com",
                    GradId = 2,
                    KorisnickoIme = "ahmo",
                    LozinkaHash = "57dqXte2i8RuxpISQMzOjW/kYUA=",
                    LozinkaSalt = "uSHCckjLFYgVNJRSWd2W5g==",
                    Telefon = "062263580",
                    DatumRegistracije = new DateTime(2025, 01, 01),
                    Status = true
                },
                new Gost()
                {
                    Id = 3,
                    Ime = "test",
                    Prezime = "novi korisnik",
                    Email = "novikorisnk.test@gmail.com",
                    GradId = 3,
                    KorisnickoIme = "test98",
                    LozinkaHash = "nEE+3SNUp4E2UX5xfPGpH6R+ELA=",
                    LozinkaSalt = "uFdyLQoAo6+BtcRfOYC0Og==",
                    Telefon = "52515215",
                    DatumRegistracije = new DateTime(2025, 02, 01),
                    Status = true
                },
                new Gost()
                {
                    Id = 4,
                    Ime = "aaaa",
                    Prezime = "dddd",
                    Email = "dd.ss@gmail.com",
                    GradId = 1,
                    KorisnickoIme = "aadd",
                    LozinkaHash = "TPBs9dFgTsf0SmZpnSfQcmyIISE=",
                    LozinkaSalt = "cJCHfu17NRuIYzB3bS9onw==",
                    Telefon = "43743743",
                    DatumRegistracije = new DateTime(2025, 04, 04),
                    Status = true
                },
                new Gost()
                {
                    Id = 5,
                    Ime = "huso",
                    Prezime = "smajkic",
                    Email = "huso.smajkic@gmail.com",
                    GradId = 4,
                    KorisnickoIme = "huso55",
                    LozinkaHash = "cLhzBmLT6jPfLssPnXTSFOLBehw=",
                    LozinkaSalt = "uy9mahnWC7AvJIt+6qeWPg==",
                    Telefon = "1234214",
                    DatumRegistracije = new DateTime(2024, 12, 31),
                    Status = false
                }
            };
            modelBuilder.Entity<Gost>().HasData(gosti);
        }
    }
}
