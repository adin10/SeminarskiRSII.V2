using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class OcjenjenaField : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "Ocjenjena",
                table: "rezervacija",
                type: "bit",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Ocjenjena",
                table: "rezervacija");
        }
    }
}
