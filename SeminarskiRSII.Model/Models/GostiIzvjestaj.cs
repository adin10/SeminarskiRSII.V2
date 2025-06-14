namespace SeminarskiRSII.Model.Models
{
    public class GostIzvjestaj
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public List<RezervacijaInfo> Rezervacije { get; set; }

    }

    public class RezervacijaInfo
    {
        public DateTime DatumRezervacije { get; set; }
        public DateTime ZavrsetakRezervacije { get; set; }
        public List<UslugaInfo> Usluge { get; set; }
        public int BrojSprata { get; set; }
        public int BrojSobe { get; set; }
        public string OpisSobe { get; set; }
        public byte[]? Slika { get; set; }
        public float UkupnaCijena { get; set; }
    }

    public class UslugaInfo
    {
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public int Cijena { get; set; }

    }

}
