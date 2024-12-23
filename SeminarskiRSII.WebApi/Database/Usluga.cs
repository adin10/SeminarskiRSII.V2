namespace SeminarskiRSII.WebApi.Database
{
    public class Usluga
    {
        public int UslugaID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public int Cijena { get; set; }
        public ICollection<RezervacijaUsluga> RezervacijaUsluge { get; set; }
    }
}
