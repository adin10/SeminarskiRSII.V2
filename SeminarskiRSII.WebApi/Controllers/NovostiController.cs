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
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.Model.Models;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NovostiController : ControllerBase
    {
        private readonly INovostiService _service;
        public NovostiController(INovostiService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Novosti>>> GetList([FromQuery] NovostiSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Novosti>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Novosti>> Insert(NovostiInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Novosti>> Update(int id, NovostiInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Novosti>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }

        [HttpPost("markAsRead")]
        public async Task<IActionResult> MarkAsRead([FromBody] MarkAsReadRequest request)
        {
            await _service.MarkAsRead(request);
            return Ok();
        }
    }

    //[AllowAnonymous]

    //public class NovostiController : BaseCRUDController<Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiInsertRequest>
    //{
    //    public NovostiController(ICRUDService<Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiInsertRequest> service) : base(service)
    //    {
    //    }
    //}
}
