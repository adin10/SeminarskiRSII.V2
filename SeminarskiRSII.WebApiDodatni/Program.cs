using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.WebApiDodatni.Database;
using SeminarskiRSII.WebApiDodatni.Services;
using System;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddScoped<IRecenzijaService, RecenzijaService>();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var connectionString = builder.Configuration.GetConnectionString("HotelAS");
builder.Services.AddDbContext<IB210330Context>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
