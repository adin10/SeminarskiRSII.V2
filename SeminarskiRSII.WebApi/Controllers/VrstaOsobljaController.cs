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
    public class VrstaOsobljaController : ControllerBase
    {
        private readonly IVrstaOsobljaService _service;
        public VrstaOsobljaController(IVrstaOsobljaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<VrstaOsoblja>>> GetList()
        {
            return Ok(await _service.GetList());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<VrstaOsoblja>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<VrstaOsoblja>> Insert(VrstaOsobljaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<VrstaOsoblja>> Update(int id, VrstaOsobljaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<VrstaOsoblja>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }
    //public class VrstaOsobljaController : BaseController<Model.VrstaOsoblja, object>
    //{
    //    public VrstaOsobljaController(IService<VrstaOsoblja, object> service) : base(service)
    //    {
    //    }
    //}
}

