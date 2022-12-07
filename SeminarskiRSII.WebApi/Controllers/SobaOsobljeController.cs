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
    public class SobaOsobljeController : ControllerBase
    {
        private readonly ISobaOsobljeService _service;
        public SobaOsobljeController(ISobaOsobljeService service)
        {
            _service = service;
        }
        [HttpGet]
        public async Task<ActionResult<List<SobaOsoblje>>> GetList()
        {
            return Ok(await _service.GetList());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SobaOsoblje>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<SobaOsoblje>> Insert(SobaOsobljeInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<SobaOsoblje>> Update(int id, SobaOsobljeInsertRequest update)
        {
            return  Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<SobaOsoblje>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }

    //public class SobaOsobljeController : BaseController<Model.SobaOsoblje, object>
    //{
    //    public SobaOsobljeController(IService<SobaOsoblje, object> service) : base(service)
    //    {

    //    }
    //}
}

