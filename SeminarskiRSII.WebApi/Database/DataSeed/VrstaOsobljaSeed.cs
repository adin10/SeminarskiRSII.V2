using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class VrstaOsobljaSeed
    {
        public static void SeedVrstaOsoblja(this ModelBuilder modelBuilder)
        {
            List<VrstaOsoblja> list = new List<VrstaOsoblja>();
            list.AddRange(new List<VrstaOsoblja>()
            {
                new VrstaOsoblja()
                {
                    Id = 1,
                    Pozicija = "Direktor",
                    Zaduzenja = "Vodjenje posla i upravljanje ljudima i poslovima"
                },
                new VrstaOsoblja() 
                {
                    Id = 2,
                    Pozicija = "Administracija",
                    Zaduzenja = "vodjenje hotela i ugovaranje dogadjaja"
                },
                new VrstaOsoblja()
                {
                    Id = 3,
                    Pozicija = "Recepcionar",
                    Zaduzenja = "Docekivanje gostiju i davanje svih potrebnih informacija"
                },
                new VrstaOsoblja()
                {
                    Id = 4,
                    Pozicija = "Spremacica",
                    Zaduzenja = "Spremanje i ciscenje soba kako bi nasi gosti bili zadovoljni uslugom"
                }
            });
            modelBuilder.Entity<VrstaOsoblja>().HasData(list);
        }
    }
}
