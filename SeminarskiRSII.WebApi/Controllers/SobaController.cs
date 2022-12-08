using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;

namespace SeminarskiRSII.WebApi.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class SobaController : ControllerBase
    {
        private readonly ISobaService _service;
        public SobaController(ISobaService service)
        {
            _service = service;
        }
        [HttpGet]
        public async Task<ActionResult<List<Soba>>> GetList([FromQuery] SobaSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Soba>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Soba>> Insert(SobaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Soba>> Update(int id, SobaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Soba>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }
    //public class SobaController : BaseCRUDController<Model.Soba, SobaSearchRequest, SobaInsertRequest, SobaInsertRequest>
    //{
    //    public SobaController(ICRUDService<Soba, SobaSearchRequest, SobaInsertRequest, SobaInsertRequest> service) : base(service)
    //    {
    //    }
    //}
}

