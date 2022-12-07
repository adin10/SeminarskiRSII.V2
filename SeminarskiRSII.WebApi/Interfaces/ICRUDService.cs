using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IService<T, TSearch>
    {
        T Insert(TInsert insert);
        T Update(int id, TUpdate update);
    }
}
