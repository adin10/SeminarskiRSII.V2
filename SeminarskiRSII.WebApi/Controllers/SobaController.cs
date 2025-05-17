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
using Microsoft.ML.Trainers;
using Microsoft.ML;

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
            var result = await _service.Insert(insert);
            if (result == null)
            {
                return BadRequest("Soba sa tim brojem već postoji.");
            }

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Soba>> Update(int id, SobaInsertRequest update)
        {
            var result = await _service.Update(id, update);
            if(result == null)
            {
                return BadRequest("Soba sa tim brojem već postoji.");
            }
            return Ok(result);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Soba>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }

        [HttpGet("recommendation")]
        public ActionResult<Soba> RecommendationSystem()
        {
            return Ok(_service.RecommendPopularRooms());
        }

        [HttpGet("sobaZauzeta/{id}")]
        public async Task<ActionResult<bool>> SobaZauzeta(int id)
        {
            return Ok(await _service.SobaZauzeta(id));
        }
    }
    //public class SobaController : BaseCRUDController<Model.Soba, SobaSearchRequest, SobaInsertRequest, SobaInsertRequest>
    //{
    //    public SobaController(ICRUDService<Soba, SobaSearchRequest, SobaInsertRequest, SobaInsertRequest> service) : base(service)
    //    {
    //    }
    //}
}

