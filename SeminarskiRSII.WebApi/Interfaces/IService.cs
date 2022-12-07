using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Interfaces
{
   public interface IService<T, TSearch>
    {
        // IService je glavni interfejs za preuzimanje podataka
        // IService cemo koristiti za getove i getByID
        List<T> get(TSearch search);
        T getByID(int id);
    }
}
