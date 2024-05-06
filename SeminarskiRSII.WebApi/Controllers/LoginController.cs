using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeminarskiRSII.Model;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebApi.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace SeminarskiRSII.WebApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private ILoginService _userService;

        public LoginController(ILoginService userService)
        {
            _userService = userService;
        }

        [AllowAnonymous]
        [HttpPost("authenticateAdministration")]
        public IActionResult AuthenticateAdministration([FromBody] Login model)
        {
            var user = _userService.Authenticiraj(model.Username, model.Password);

            if (user is null)
                return BadRequest(new { message = "Username or password is incorrect" });

            return Ok(user);
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] Login model)
        {
            var user = _userService.AuthenticirajGosta(model.Username, model.Password);

            if (user is null)
                return BadRequest(new { message = "Username or password is incorrect" });

            return Ok(user);
        }
    }
}
