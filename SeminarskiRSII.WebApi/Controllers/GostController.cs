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
    [Route("api/[controller]")]
    [ApiController]
    public class GostController : ControllerBase
    {
        private readonly IGostService _service;
        public GostController(IGostService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<Gost>>> GetList([FromQuery] GostiSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Gost>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Gost>> Insert(GostiInsertRequest request)
        {
            return Ok(await _service.Insert(request));
        }

        [Authorize]
        [HttpPut("{id}")]
        public async Task<ActionResult<Gost>> Update(int id, GostiInsertRequest request)
        {
            return Ok(await _service.Update(id, request));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Gost>> Delete(int id)
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
                return Ok(updatedUser);
            }
            catch (UserException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal server error: " + ex.Message);
            }
        }

        [HttpPut("UpdateProfile/{id}")]
        public async Task<ActionResult<Gost>> UpdateProfile(int id, UpdateUserProfile request)
        {
            return Ok(await _service.UpdateUserProfile(id, request));
        }

        [HttpPut("UpdateInformation/{id}")]
        public async Task<ActionResult<Gost>> UpdateInformation(int id, GostiUpdateRequest request)
        {
            return Ok(await _service.UpdateInformation(id, request));
        }
    }
}
