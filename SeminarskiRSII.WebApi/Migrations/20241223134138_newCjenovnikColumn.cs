using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class newCjenovnikColumn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "BrojDana",
                table: "cjenovnik");

            migrationBuilder.AddColumn<string>(
                name: "Valuta",
                table: "cjenovnik",
                type: "nvarchar(max)",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Valuta",
                table: "cjenovnik");

            migrationBuilder.AddColumn<int>(
                name: "BrojDana",
                table: "cjenovnik",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
