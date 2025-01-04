using Microsoft.AspNetCore.Connections;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Connections;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.WebApiDodatni.Services;
using System.Text;
using Newtonsoft.Json;
using RabbitMQ.Client;

namespace SeminarskiRSII.WebApiDodatni.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecenzijaController : ControllerBase
    {
        private readonly IRecenzijaService _service;
        public RecenzijaController(IRecenzijaService service)
        {
            _service = service;
        }

        //[HttpGet("top")]
        //public async Task<IActionResult> GetTopRecenzije([FromQuery] int minOcjena = 4)
        //{
        //    return Ok(await _service.GetTopRecenzije(minOcjena));
        //}

        [HttpGet]
        public virtual async Task<List<Dtos.Recenzija>> Get([FromQuery] int minOcjena)
        {
            var result = await _service.GetTopRecenzije(minOcjena);
            var factory = new ConnectionFactory
            {
                //HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ"
                HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost" // sa ovim radi u localu (potrebno izmjeniti)
            };
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "recenzija",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: true,
                                 arguments: null);


            var json = JsonConvert.SerializeObject(result);

            var body = Encoding.UTF8.GetBytes(json);

            Console.WriteLine($"Sending recenzija: {json}");

            channel.BasicPublish(exchange: string.Empty,
                                 routingKey: "recenzija",

                                 body: body);
            return result;
        }
    }
}
