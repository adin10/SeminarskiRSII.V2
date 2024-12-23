using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.OpenApi.Models;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebApi.Security;
using SeminarskiRSII.WebApi.Services;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

var builder = WebApplication.CreateBuilder(args);
builder.Services.Configure<JsonOptions>(options =>
{
    options.SerializerOptions.PropertyNameCaseInsensitive = true;
});

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddControllersWithViews()
    .AddNewtonsoftJson(options =>
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var connection = builder.Configuration.GetConnectionString("HotelAS");
builder.Services.AddDbContext<IB210330Context>(options => options.UseSqlServer(connection));
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<IDrzavaService, DrzavaService>();
builder.Services.AddScoped<IGradService, GradService>();
builder.Services.AddScoped<ICjenovnikService, CjenovnikService>();
builder.Services.AddScoped<ISobaService, SobaService>();
builder.Services.AddScoped<IGostService, GostService>();
builder.Services.AddScoped<ISobaStatusService, SobaStatusService>();
builder.Services.AddScoped<ISobaOsobljeService, SobaOsobljeService>();
builder.Services.AddScoped<IVrstaOsobljaService, VrstaOsobljaService>();
builder.Services.AddScoped<IRecenzijaService, RecenzijaService>();
builder.Services.AddScoped<IRezervacijaService, RezervacijaService>();
builder.Services.AddScoped<IOsobljeService, OsobljeService>();
builder.Services.AddScoped<INovostiService, NovostiService>();
builder.Services.AddScoped<INotifikacijeService, NotifikacijeService>();
builder.Services.AddScoped<IUslugaService, UslugaService>();
builder.Services.AddScoped<IGostiNotifikacijeService, GostiNotifikacijeService>();

//builder.Services.AddScoped<ICRUDService<Model.Models.Notifikacije, NotifikacijeSearchRequest, NotifikacijeInsertRequest, NotifikacijeInsertRequest>, NotifikacijaService>();
//builder.Services.AddScoped<INovostiService, NovostiService>();
//builder.Services.AddScoped<ICRUDService<Model.Models.GostiNotifikacije, GostiNotifikacijeSearchRequest, GostiNotifikacijeInsertRequest, GostiNotifikacijeInsertRequest>, GostiNotifikacijeService>();

builder.Services.AddAuthentication("BasicAuthentification")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentification", null);
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
            },
            new string[]{}
        }
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseStaticFiles(); // Za sliku
//app.UseStaticFiles(new StaticFileOptions
//{
//    FileProvider = new PhysicalFileProvider(Path.Combine(Directory.GetCurrentDirectory(), @"Images")),
//    RequestPath = new PathString("/Images")
//});

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
