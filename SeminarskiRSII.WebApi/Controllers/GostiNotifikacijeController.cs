using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GostiNotifikacijeController : ControllerBase
    {
        private readonly IGostiNotifikacijeService _service;
        public GostiNotifikacijeController(IGostiNotifikacijeService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<GostiNotifikacije>>> GetList([FromQuery] GostiNotifikacijeSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

    }
    //public class GostiNotifikacijeController : BaseCRUDController<GostiNotifikacije, GostiNotifikacijeSearchRequest, GostiNotifikacijeInsertRequest, GostiNotifikacijeInsertRequest>
    //{
    //    public GostiNotifikacijeController(ICRUDService<GostiNotifikacije, GostiNotifikacijeSearchRequest, GostiNotifikacijeInsertRequest, GostiNotifikacijeInsertRequest> service) : base(service)
    //    {
    //    }
    //}
}
