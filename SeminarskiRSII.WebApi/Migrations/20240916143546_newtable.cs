using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class newtable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "UslugaId",
                table: "rezervacija",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Usluga",
                columns: table => new
                {
                    UslugaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usluga", x => x.UslugaID);
                });

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

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_rezervacija_Usluga_UslugaId",
                table: "rezervacija");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropIndex(
                name: "IX_rezervacija_UslugaId",
                table: "rezervacija");

            migrationBuilder.DropColumn(
                name: "UslugaId",
                table: "rezervacija");
        }
    }
}
