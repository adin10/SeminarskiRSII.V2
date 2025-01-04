namespace SeminarskiRSII.WebApiDodatni.Database
{
    public class Recenzija
    {
        public int Id { get; set; }
        public int GostId { get; set; }
        public int SobaId { get; set; }
        public int Ocjena { get; set; }
        public string? Komentar { get; set; }
    }
}
