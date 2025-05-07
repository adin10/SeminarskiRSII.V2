namespace SeminarskiRSII.WebApi.Database
{
    public class NovostProcitana
    {
        public int Id { get; set; }
        public int? NovostId { get; set; }
        public Novosti? Novost { get; set; }
        public int? GostId { get; set; }
        public Gost? Gost { get; set; }
        public DateTime Datum { get; set; }
    }
}
