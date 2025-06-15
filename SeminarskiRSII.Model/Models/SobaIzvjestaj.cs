namespace SeminarskiRSII.Model.Models
{
    public class SobaIzvjestaj
    {
        public int BrojSobe { get; set; }
        public int BrojSprata { get; set; }
        public string OpisSobe { get; set; }
        public byte[] Slika { get; set; }
        public List<RezervacijaZaSobuInfo> Rezervacije { get; set; }
    }

    public class RezervacijaZaSobuInfo
    {
        public DateTime DatumRezervacije { get; set; }
        public DateTime ZavrsetakRezervacije { get; set; }
        public string GostIme { get; set; }
        public string GostPrezime { get; set; }
        public float Cijena { get; set; }
        public List<UslugaSobaInfo> Usluge { get; set; }
    }

    public class UslugaSobaInfo
    {
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public int Cijena { get; set; }
    }
}
