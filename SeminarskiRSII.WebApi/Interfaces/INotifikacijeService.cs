using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
   public interface INotifikacijeService
    {
        public Task<List<Notifikacije>> GetList(NotifikacijeSearchRequest search);
        Task NotifyUserAboutNewReservation(long reservationId);
        Task NotifyUserAboutCancelledReservation(long reservationId);

    }
}
