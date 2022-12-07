using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SeminarskiRSII.Model;
using Microsoft.AspNetCore.Authorization;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.Model.Models;

namespace SeminarskiRSII.WebApi.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    //public class NovostiController : ControllerBase
    //{
    //    private readonly INovostiService _service;
    //    public NovostiController(INovostiService service)
    //    {
    //        _service = service;
    //    }
    //    [HttpGet]
    //    public ActionResult<List<Model.Novosti>> Get([FromQuery] NovostiSearchRequest search)
    //    {
    //        return _service.get(search);
    //    }
    //    [HttpGet("{id}")]
    //    public ActionResult<Model.Novosti> GetByID(int id)
    //    {
    //        return _service.getByID(id);
    //    }
    //    [HttpPost]
    //    public Model.Novosti Insert(NovostiInsertRequest insert)
    //    {
    //        return _service.Insert(insert);
    //    }
    //    [HttpPut("{id}")]
    //    public Model.Novosti Update(int id, NovostiInsertRequest update)
    //    {
    //        return _service.Update(id, update);
    //    }
    //}

    [AllowAnonymous]

    public class NovostiController : BaseCRUDController<Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiInsertRequest>
    {
        public NovostiController(ICRUDService<Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiInsertRequest> service) : base(service)
        {
        }
    }
}
