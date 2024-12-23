using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class rezervacijaUsluga : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_rezervacija_Usluga_UslugaId",
                table: "rezervacija");

            migrationBuilder.DropIndex(
                name: "IX_rezervacija_UslugaId",
                table: "rezervacija");

            migrationBuilder.DropColumn(
                name: "UslugaId",
                table: "rezervacija");

            migrationBuilder.AddColumn<float>(
                name: "Cijena",
                table: "rezervacija",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.CreateTable(
                name: "RezervacijaUsluga",
                columns: table => new
                {
                    RezervacijaUslugaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RezervacijaID = table.Column<int>(type: "int", nullable: true),
                    UslugaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaUsluga", x => x.RezervacijaUslugaID);
                    table.ForeignKey(
                        name: "FK_RezervacijaUsluga_rezervacija_RezervacijaID",
                        column: x => x.RezervacijaID,
                        principalTable: "rezervacija",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_RezervacijaUsluga_Usluga_UslugaId",
                        column: x => x.UslugaId,
                        principalTable: "Usluga",
                        principalColumn: "UslugaID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluga_RezervacijaID",
                table: "RezervacijaUsluga",
                column: "RezervacijaID");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluga_UslugaId",
                table: "RezervacijaUsluga",
                column: "UslugaId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijaUsluga");

            migrationBuilder.DropColumn(
                name: "Cijena",
                table: "rezervacija");

            migrationBuilder.AddColumn<int>(
                name: "UslugaId",
                table: "rezervacija",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_rezervacija_UslugaId",
                table: "rezervacija",
                column: "UslugaId");

            migrationBuilder.AddForeignKey(
                name: "FK_rezervacija_Usluga_UslugaId",
                table: "rezervacija",
                column: "UslugaId",
                principalTable: "Usluga",
                principalColumn: "UslugaID");
        }
    }
}
