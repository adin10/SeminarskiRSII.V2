using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class NoveKolone : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "Slika",
                table: "novosti",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "NovostProcitana",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NovostId = table.Column<int>(type: "int", nullable: true),
                    GostId = table.Column<int>(type: "int", nullable: true),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NovostProcitana", x => x.Id);
                    table.ForeignKey(
                        name: "FK_NovostProcitana_gost_GostId",
                        column: x => x.GostId,
                        principalTable: "gost",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_NovostProcitana_novosti_NovostId",
                        column: x => x.NovostId,
                        principalTable: "novosti",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_NovostProcitana_GostId",
                table: "NovostProcitana",
                column: "GostId");

            migrationBuilder.CreateIndex(
                name: "IX_NovostProcitana_NovostId",
                table: "NovostProcitana",
                column: "NovostId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "NovostProcitana");

            migrationBuilder.DropColumn(
                name: "Slika",
                table: "novosti");
        }
    }
}
