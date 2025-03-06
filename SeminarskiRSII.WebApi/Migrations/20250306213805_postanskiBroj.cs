using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class postanskiBroj : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 1,
                column: "PostanskiBroj",
                value: 88000);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 2,
                column: "PostanskiBroj",
                value: 71000);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 3,
                column: "PostanskiBroj",
                value: 75000);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 4,
                column: "PostanskiBroj",
                value: 44000);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 5,
                column: "PostanskiBroj",
                value: 49000);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 6,
                column: "PostanskiBroj",
                value: 77000);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 1,
                column: "PostanskiBroj",
                value: 0);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 2,
                column: "PostanskiBroj",
                value: 0);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 3,
                column: "PostanskiBroj",
                value: 0);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 4,
                column: "PostanskiBroj",
                value: 0);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 5,
                column: "PostanskiBroj",
                value: 0);

            migrationBuilder.UpdateData(
                table: "grad",
                keyColumn: "ID",
                keyValue: 6,
                column: "PostanskiBroj",
                value: 0);
        }
    }
}
