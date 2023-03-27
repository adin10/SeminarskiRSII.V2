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

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RezervacijaController : ControllerBase
    {
        private readonly IRezervacijaService _service;

        public RezervacijaController(IRezervacijaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Rezervacija>>> GetList([FromQuery] RezervacijaSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Rezervacija>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Rezervacija>> Insert(RezervacijaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Rezervacija>> Update(int id, RezervacijaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Rezervacija>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }

        [HttpGet("{gostID}/recommended")]
        public List<Rezervacija> Recommended(int gostID)
        {
            return _service.Recommend(gostID);
        }

    }
}
