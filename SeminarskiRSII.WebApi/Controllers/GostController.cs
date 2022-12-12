using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.Model.Models;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GostController : ControllerBase
    {
        private readonly IGostService _service;
        public GostController(IGostService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Gost>>> GetList([FromQuery] GostiSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Gost>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Gost>> Insert(GostiInsertRequest request)
        {
            return Ok(await _service.Insert(request));
        }

        [Authorize]
        [HttpPut("{id}")]
        public async Task<ActionResult<Gost>> Update(int id, GostiInsertRequest request)
        {
            return Ok(await _service.Update(id, request));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Gost>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }
}
