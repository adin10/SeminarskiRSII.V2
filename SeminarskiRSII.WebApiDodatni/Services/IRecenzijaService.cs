using SeminarskiRSII.WebApiDodatni.Database;

namespace SeminarskiRSII.WebApiDodatni.Services
{
    public interface IRecenzijaService
    {
        Task<List<Dtos.Recenzija>> GetTopRecenzije(int minOcjena);
    }
}
