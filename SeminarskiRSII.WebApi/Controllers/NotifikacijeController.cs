using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model;
using Microsoft.AspNetCore.Authorization;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotifikacijeController : ControllerBase
    {
        private readonly INotifikacijeService _service;
        public NotifikacijeController(INotifikacijeService service)
        {
            _service = service;
        }
        [HttpGet]
        public async Task<ActionResult<List<Notifikacije>>> GetList([FromQuery] NotifikacijeSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }
    }


    //[AllowAnonymous]

    //public class NotifikacijeController : BaseCRUDController<Notifikacije, NotifikacijeSearchRequest, NotifikacijeInsertRequest, NotifikacijeInsertRequest>
    //{
    //    public NotifikacijeController(ICRUDService<Notifikacije, NotifikacijeSearchRequest, NotifikacijeInsertRequest, NotifikacijeInsertRequest> service) : base(service)
    //    {
    //    }
    //}
}
