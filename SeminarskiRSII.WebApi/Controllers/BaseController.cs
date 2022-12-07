using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.WebApi.Interfaces;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseController<T, TSearch> : ControllerBase where TSearch : class
    {
        protected IService<T, TSearch> _service;

        public BaseController(IService<T, TSearch> service)
        {
            _service = service;
        }


        [HttpGet]
        public List<T> Get([FromQuery] TSearch search = null)
        {
            return _service.get(search);
        }

        [HttpGet("{id}")]
        public T Get(int id)
        {
            return _service.getByID(id);
        }
    }
}
