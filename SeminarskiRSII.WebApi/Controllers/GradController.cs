using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class GradController : ControllerBase
    {
        private readonly IGradService _gradService;
        public GradController(IGradService gradService)
        {
            _gradService = gradService;
        }

        [HttpGet]
        public async Task<ActionResult<List<Grad>>> GetList([FromQuery] GradSearchRequest request)
        {
            return Ok(await _gradService.GetList(request));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Grad>> Get(int id)
        {
            return Ok(await _gradService.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Grad>> Insert(GradInsertRequest request)
        {
            return Ok(await _gradService.Insert(request));
        }
        
        [HttpPut("{id}")]
        public async Task<ActionResult<Grad>> Update(int id, GradInsertRequest request)
        {
            return Ok(await _gradService.Update(id, request));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Grad>> Delete(int id)
        {
            return Ok(await _gradService.Delete(id));
        }
    }
}
