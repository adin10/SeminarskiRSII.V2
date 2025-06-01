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
using Stripe;
using Microsoft.Extensions.Options;

namespace SeminarskiRSII.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RezervacijaController : ControllerBase
    {
        private readonly IRezervacijaService _service;
        private readonly StripeSettings _stripeSettings;

        public RezervacijaController(IRezervacijaService service, IOptions<StripeSettings> stripeOptions)
        {
            _service = service;
            _stripeSettings = stripeOptions.Value;
            StripeConfiguration.ApiKey = _stripeSettings.SecretKey;
        }

        [HttpGet]
        public async Task<ActionResult<List<Rezervacija>>> GetList([FromQuery] RezervacijaSearchRequest search)
        {
            return Ok(await _service.GetList(search));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Rezervacija>> Get(int id)
        {
            return Ok(await _service.Get(id));
        }

        [HttpPost]
        public async Task<ActionResult<Rezervacija>> Insert(RezervacijaInsertRequest insert)
        {
            return Ok(await _service.Insert(insert));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Rezervacija>> Update(int id, RezervacijaInsertRequest update)
        {
            return Ok(await _service.Update(id, update));
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Rezervacija>> Delete(int id)
        {
            return Ok(await _service.Delete(id));
        }

        [HttpPost("create-payment-intent")]
        public async Task<IActionResult> CreatePaymentIntent([FromBody] RezervacijaInsertRequest request)
        {
            try
            {
                var izracunataCijena = await _service.CalculateTotalPrice(
                    request.SobaId.Value,
                    request.DatumRezervacije,
                    request.ZavrsetakRezervacije,
                    request.UslugaIds
                );

                var options = new PaymentIntentCreateOptions
                {
                    Amount = (long)(izracunataCijena * 100),
                    Currency = "BAM",
                    AutomaticPaymentMethods = new PaymentIntentAutomaticPaymentMethodsOptions
                    {
                        Enabled = true,
                    },
                };

                var service = new PaymentIntentService();
                var intent = service.Create(options);

                return Ok(new { clientSecret = intent.ClientSecret });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Stripe greška: {ex.Message}");
                return StatusCode(500, new { error = ex.Message });
            }
        }
    }
}
