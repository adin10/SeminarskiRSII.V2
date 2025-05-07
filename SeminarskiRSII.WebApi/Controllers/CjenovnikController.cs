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
    public class CjenovnikController : ControllerBase
    {
        private readonly ICjenovnikService _service;
        public CjenovnikController(ICjenovnikService service)
        {
            _service = service;
        }
        [HttpGet]
        public async Task<ActionResult<List<Cjenovnik>>> GetList()
        {
            return Ok(await _service.GetList());
        }

        [HttpGet("getAllCijene")]
        public async Task<ActionResult<List<Cjenovnik>>> getAllCijene()
        {
            return Ok(await _service.getAllCijene());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Cjenovnik>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Cjenovnik>> Insert(CijenaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Cjenovnik>> Update(int id, CijenaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Cjenovnik>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }
}
