using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebAPI.Exceptions;

namespace SeminarskiRSII.WebApi.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class OsobljeController : ControllerBase
    {
        private readonly IOsobljeService _service;
        public OsobljeController(IOsobljeService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Osoblje>>> GetList([FromQuery] OsobljeSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Osoblje>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        //[Authorize(Roles = "Direktor")]
        [HttpPost]
        public async Task<ActionResult<Osoblje>> Insert([FromBody] OsobljeInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        //[Authorize(Roles = "Direktor")]
        [HttpPut("{id}")]
        public async Task<ActionResult<Osoblje>> Update(int id, [FromBody] OsobljeInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Osoblje>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }

        [HttpPut("ChangePassword/{id}")]
        public async Task<IActionResult> ChangePassword(int id, [FromBody] ChangePasswordRequest request)
        {
            if (request == null)
            {
                return BadRequest("Request cannot be null");
            }

            try
            {
                var updatedUser = await _service.ChangePassword(id, request);
                return Ok(updatedUser); // Return 200 OK with the updated user
            }
            catch (UserException ex)
            {
                return BadRequest(ex.Message); // Return 400 BadRequest with the exception message
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal server error: " + ex.Message); // Return 500 Internal Server Error
            }
        }
    }
}
}
