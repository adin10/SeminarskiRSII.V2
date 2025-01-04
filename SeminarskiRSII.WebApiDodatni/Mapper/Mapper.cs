using AutoMapper;
using SeminarskiRSII.WebApiDodatni.Database;

namespace SeminarskiRSII.WebApiDodatni.Mapper
{
    public class Mapper: Profile
    {
        public Mapper() {
            CreateMap<Database.Recenzija, Dtos.Recenzija>();
        }
    }
}
