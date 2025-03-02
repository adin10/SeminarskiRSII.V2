using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class cjenovnikSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "cjenovnik",
                columns: new[] { "ID", "cijena", "sobaID", "Valuta" },
                values: new object[] { 1, 50f, 1, "KM" });

            migrationBuilder.InsertData(
                table: "cjenovnik",
                columns: new[] { "ID", "cijena", "sobaID", "Valuta" },
                values: new object[] { 2, 150f, 2, "KM" });

            migrationBuilder.InsertData(
                table: "cjenovnik",
                columns: new[] { "ID", "cijena", "sobaID", "Valuta" },
                values: new object[] { 3, 100f, 3, "KM" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "cjenovnik",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "cjenovnik",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "cjenovnik",
                keyColumn: "ID",
                keyValue: 3);
        }
    }
}
