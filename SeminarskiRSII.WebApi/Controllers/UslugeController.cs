using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebApi.Services;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UslugeController : ControllerBase
    {
        private readonly IUslugaService _service;

        public UslugeController(IUslugaService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Usluga>>> GetList()
        {
            return Ok(await _service.GetList());
        }

        [HttpPost]
        public async Task<ActionResult<Usluga>> Insert(UslugaInsertRequest request)
        {
            return Ok(await _service.Insert(request));
        }
    }
}
