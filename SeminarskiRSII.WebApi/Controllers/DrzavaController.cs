using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DrzavaController : ControllerBase
    {
        private readonly IDrzavaService _drzavaService;
        public DrzavaController(IDrzavaService drzavaService)
        {
            _drzavaService = drzavaService;
        }

        [HttpGet]
        public async Task<ActionResult<List<Drzava>>> GetList([FromQuery]DrzavaSearchRequest request)
        {
            return Ok(await _drzavaService.GetList(request));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Drzava>> GetList(int id)
        {
            return Ok(await _drzavaService.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Drzava>> Insert(DrzavaInsertRequest request)
        {
            return Ok(await _drzavaService.Insert(request));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Drzava>> Update(int id, DrzavaInsertRequest request)
        {
            return Ok(await _drzavaService.Update(id,request));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Drzava>> Delete(int id)
        {
            return Ok(await _drzavaService.Delete(id));
        }
    }
}
