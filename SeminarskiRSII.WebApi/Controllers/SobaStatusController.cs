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
    public class SobaStatusController : ControllerBase
    {
        private readonly ISobaStatusService _service;
        public SobaStatusController(ISobaStatusService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<SobaStatus>>> GetList()
        {
            return Ok(await _service.GetList());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SobaStatus>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<SobaStatus>> Insert(SobaStatusInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<SobaStatus>> Update(int id, SobaStatusInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<SobaStatus>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }
    }
    //public class SobaStatusController : BaseController<Model.SobaStatus, object>
    //{
    //    public SobaStatusController(IService<SobaStatus, object> service) : base(service)
    //    {

    //    }
    //}
}

