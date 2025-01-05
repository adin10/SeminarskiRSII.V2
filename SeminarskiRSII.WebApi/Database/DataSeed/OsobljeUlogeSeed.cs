using Microsoft.EntityFrameworkCore;

namespace SeminarskiRSII.WebApi.Database.DataSeed
{
    public static class OsobljeUlogeSeed
    {
        public static void SeedOsobljeUloge(this ModelBuilder modelBuilder)
        {
            List<OsobljeUloge> list = new List<OsobljeUloge>();
            list.AddRange(new List<OsobljeUloge>()
            {
                new OsobljeUloge()
                {
                    OsobljeUlogeId = 1,
                    OsobljeId = 1,
                    VrstaOsobljaId = 1,
                    DatumIzmjene = new DateTime(2024, 12, 31)
                },
                new OsobljeUloge()
                {
                    OsobljeUlogeId = 2,
                    OsobljeId = 2,
                    VrstaOsobljaId = 3,
                    DatumIzmjene = new DateTime(2025, 1, 1)
                },
                new OsobljeUloge()
                {
                    OsobljeUlogeId = 3,
                    OsobljeId = 3,
                    VrstaOsobljaId = 4,
                    DatumIzmjene = new DateTime(2025, 1, 1)
                },
                new OsobljeUloge()
                {
                    OsobljeUlogeId = 4,
                    OsobljeId = 4,
                    VrstaOsobljaId = 3,
                    DatumIzmjene = new DateTime(2025, 1, 2)
                }
            });
            modelBuilder.Entity<OsobljeUloge>().HasData(list);
        }
    }
}
