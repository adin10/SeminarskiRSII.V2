using AutoMapper;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Mappers
{
    public class Mapper:Profile
    {
        public Mapper()
        {
            CreateMap<Database.Osoblje, Osoblje>().ReverseMap();
            CreateMap<Database.OsobljeUloge, OsobljeUloge>().ReverseMap();
            CreateMap<OsobljeInsertRequest, Database.Osoblje>().ReverseMap();
            CreateMap<Database.Gost, Osoblje>().ReverseMap();

            CreateMap<Database.VrstaOsoblja, VrstaOsoblja>();
            CreateMap<Database.VrstaOsoblja, VrstaOsoblja>().ReverseMap();

            CreateMap<VrstaOsobljaInsertRequest, Database.VrstaOsoblja>();

            CreateMap<Database.SobaStatus, SobaStatus>();
            CreateMap<SobaStatusInsertRequest, Database.SobaStatus>();

            CreateMap<Database.Soba, Soba>();
            CreateMap<SobaInsertRequest, Database.Soba>();

            CreateMap<Database.SobaOsoblje, SobaOsoblje>();
            CreateMap<SobaOsobljeInsertRequest, Database.SobaOsoblje>();

            CreateMap<Database.Drzava, Drzava>();
            CreateMap<DrzavaSearchRequest, Database.Drzava>();
            CreateMap<DrzavaInsertRequest, Database.Drzava>();



            CreateMap<Database.Grad, Grad>();
            CreateMap<GradInsertRequest, Database.Grad>();

            CreateMap<Database.OsobljeUloge, OsobljeUloge>().ReverseMap();


            CreateMap<Database.Gost, Gost>().ReverseMap();
            CreateMap<GostiInsertRequest, Database.Gost>();

            CreateMap<Database.Cjenovnik, Cjenovnik>();
            CreateMap<CijenaInsertRequest, Database.Cjenovnik>();

            CreateMap<Database.Rezervacija, Rezervacija>();
            CreateMap<RezervacijaInsertRequest, Database.Rezervacija>();

            CreateMap<Database.Recenzija,Recenzija>();
            CreateMap<RecenzijaInsertRequest, Database.Recenzija>();


            //CreateMap<Database.Notifikacije, Model.Notifikacije>();
            //CreateMap<NotifikacijeInsertRequest, Database.Notifikacije>();
            CreateMap<Database.Notifikacije, Notifikacije>();
            CreateMap<NotifikacijeInsertRequest, Database.Notifikacije>();
            

            //CreateMap<Database.Novosti, Model.Novosti>();
            //CreateMap<NovostiInsertRequest, Database.Novosti>();
            CreateMap<Database.Novosti, Novosti>();
            CreateMap<NovostiInsertRequest, Database.Novosti>();


            //CreateMap<Database.GostiNotifikacije, Model.GostiNotifikacije>();
            CreateMap<Database.GostiNotifikacije, GostiNotifikacije>();
            CreateMap<GostiNotifikacijeInsertRequest, Database.GostiNotifikacije>();


        }
    }
}
