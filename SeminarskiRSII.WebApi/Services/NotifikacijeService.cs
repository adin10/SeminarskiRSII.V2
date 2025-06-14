using AutoMapper;
using SeminarskiRSII.Model;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;
using Microsoft.Extensions.Options;
using SeminarskiRSII.WebApi.Util;
using Microsoft.AspNetCore.SignalR;
using SeminarskiRSII.RabbitMQConsumer;

namespace SeminarskiRSII.WebApi.Services
{
    public class NotifikacijeService : INotifikacijeService
    {

        private readonly IB210330Context _context;
        private readonly IMapper _mapper;
        private readonly IRabbitMQProducer _rabbitMQProducer;
        private readonly MailConfig _mailConfig;

        public NotifikacijeService(IB210330Context context, IMapper mapper, IRabbitMQProducer rabbitMQProducer, IOptionsSnapshot<MailConfig> mailConfig)
        {
            _context = context;
            _mapper = mapper;
            _rabbitMQProducer = rabbitMQProducer;
            _mailConfig = mailConfig.Value;
        }

        public async Task<List<Model.Models.Notifikacije>> GetList(NotifikacijeSearchRequest search)
        {
            var query = _context.Notifikacije.Include(x => x.Novost).AsQueryable();
            if (search != null)
            {
                if (!string.IsNullOrWhiteSpace(search.Naslov))
                {
                    query = query.Where(x => x.Naslov.ToLower().Contains(search.Naslov));
                } 
                if (search.NovostId.HasValue)
                {
                    query= query.Where(x=>x.NovostId== search.NovostId.Value);
                }
            }
            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Notifikacije>>(list);
        }

        public async Task NotifyUserAboutCancelledReservation(long reservationId)
        {
            var reservation = await _context.Rezervacija.
                Include(x => x.Gost).Include(x => x.Soba)
                .FirstOrDefaultAsync(x => x.Id == reservationId);

            if (reservation == null) return;

            var mail = new MailDto
            {
                Sender = "adin.smajkic@gmail.com",
                Recipient = reservation.Gost.Email ?? "",
                Subject = $"Vasa rezervacije sobe: {reservation.Soba.BrojSobe} je otkazana",
                Content = $"Vasa rezervacija broj {reservation.Id} po cijeni {reservation.Cijena}KM je otkazana."
            };

            _rabbitMQProducer.SendMessage(mail);
        }

        public async Task NotifyUserAboutNewReservation(long reservationId)
        {
            var reservation = await _context.Rezervacija
                .Include(x => x.Gost).Include(x => x.Soba)
                .FirstOrDefaultAsync(x => x.Id == reservationId);

            if (reservation == null) return;

            var mail = new MailDto
            {
                Sender = "adin.smajkic@gmail.com",
                Recipient = reservation.Gost.Email ?? "",
                Subject = $"Uspjesno ste rezervisali sobu broj: {reservation.Soba.BrojSobe}",
                Content = $"Rezervacija broj {reservation.Id} je kreirana uspješno. Cijena Rezervacije iznosi {reservation.Cijena}KM"
            };

            _rabbitMQProducer.SendMessage(mail);
        }
    }
}

