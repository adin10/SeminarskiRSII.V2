namespace SeminarskiRSII.WebApi.Database
{
    public class RezervacijaUsluga
    {
        public int RezervacijaUslugaID { get; set; }
        public int? RezervacijaID { get; set; }
        public Rezervacija? Rezervacija { get; set; }
        public int? UslugaId { get; set; }
        public Usluga? Usluga { get; set; }
    }
}
