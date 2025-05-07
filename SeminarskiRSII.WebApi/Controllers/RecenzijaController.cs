using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.Model.Models;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecenzijaController : ControllerBase
    {
        private readonly IRecenzijaService _service;
        public RecenzijaController(IRecenzijaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Recenzija>>> GetList([FromQuery] RecenzijaSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Recenzija>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Recenzija>> Insert(RecenzijaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Recenzija>> Update(int id, RecenzijaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpPut("obrisiKomentar/{id}")]
        public async Task<ActionResult<Recenzija>> ObrisiKomentar(int id)
        {
            return Ok(await _service.ObrisiKomentar(id));
        }
    }
}
