using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    public partial class Initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "drzava",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_drzava", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "osoblje",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_osoblje", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "sobaStatus",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    status = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sobaStatus", x => x.ID);
                });

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

            migrationBuilder.CreateTable(
                name: "vrstaOsoblja",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    pozicija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    zaduzenja = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vrstaOsoblja", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "grad",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    nazivGrada = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PostanskiBroj = table.Column<int>(type: "int", nullable: false),
                    drzavaID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_grad", x => x.ID);
                    table.ForeignKey(
                        name: "FK_grad_drzava_drzavaID",
                        column: x => x.drzavaID,
                        principalTable: "drzava",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "novosti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumObjave = table.Column<DateTime>(type: "datetime2", nullable: true),
                    osobljeID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_novosti", x => x.Id);
                    table.ForeignKey(
                        name: "FK_novosti_osoblje_osobljeID",
                        column: x => x.osobljeID,
                        principalTable: "osoblje",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "soba",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojSprata = table.Column<int>(type: "int", nullable: false),
                    BrojSobe = table.Column<int>(type: "int", nullable: false),
                    opisSobe = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    PictureName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PicturePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sobaStatusID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_soba", x => x.ID);
                    table.ForeignKey(
                        name: "FK_soba_sobaStatus_sobaStatusID",
                        column: x => x.sobaStatusID,
                        principalTable: "sobaStatus",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "osobljeUloge",
                columns: table => new
                {
                    OsobljeUlogeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    osobljeID = table.Column<int>(type: "int", nullable: false),
                    vrstaOsobljaID = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_osobljeUloge", x => x.OsobljeUlogeID);
                    table.ForeignKey(
                        name: "FK_osobljeUloge_osoblje_osobljeID",
                        column: x => x.osobljeID,
                        principalTable: "osoblje",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_osobljeUloge_vrstaOsoblja_vrstaOsobljaID",
                        column: x => x.vrstaOsobljaID,
                        principalTable: "vrstaOsoblja",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "gost",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    gradID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_gost", x => x.ID);
                    table.ForeignKey(
                        name: "FK_gost_grad_gradID",
                        column: x => x.gradID,
                        principalTable: "grad",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "notifikacije",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumSlanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NovostId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_notifikacije", x => x.Id);
                    table.ForeignKey(
                        name: "FK_notifikacije_novosti_NovostId",
                        column: x => x.NovostId,
                        principalTable: "novosti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "cjenovnik",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    sobaID = table.Column<int>(type: "int", nullable: false),
                    Valuta = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    cijena = table.Column<float>(type: "real", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_cjenovnik", x => x.ID);
                    table.ForeignKey(
                        name: "FK_cjenovnik_soba_sobaID",
                        column: x => x.sobaID,
                        principalTable: "soba",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "sobaOsoblje",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    sobaID = table.Column<int>(type: "int", nullable: false),
                    osobljeID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sobaOsoblje", x => x.ID);
                    table.ForeignKey(
                        name: "FK_sobaOsoblje_osoblje_osobljeID",
                        column: x => x.osobljeID,
                        principalTable: "osoblje",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_sobaOsoblje_soba_sobaID",
                        column: x => x.sobaID,
                        principalTable: "soba",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "recenzija",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    gostID = table.Column<int>(type: "int", nullable: false),
                    sobaID = table.Column<int>(type: "int", nullable: false),
                    ocjena = table.Column<int>(type: "int", nullable: false),
                    komentar = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_recenzija", x => x.ID);
                    table.ForeignKey(
                        name: "FK_recenzija_gost_gostID",
                        column: x => x.gostID,
                        principalTable: "gost",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_recenzija_soba_sobaID",
                        column: x => x.sobaID,
                        principalTable: "soba",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "rezervacija",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    gostID = table.Column<int>(type: "int", nullable: false),
                    sobaID = table.Column<int>(type: "int", nullable: false),
                    datumRezervacije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    zavrsetakRezervacije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Qrcode = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    Otkazana = table.Column<bool>(type: "bit", nullable: true),
                    Cijena = table.Column<float>(type: "real", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_rezervacija", x => x.ID);
                    table.ForeignKey(
                        name: "FK_rezervacija_gost_gostID",
                        column: x => x.gostID,
                        principalTable: "gost",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_rezervacija_soba_sobaID",
                        column: x => x.sobaID,
                        principalTable: "soba",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "gostiNotifikacije",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    notifikacijeId = table.Column<int>(type: "int", nullable: true),
                    gostID = table.Column<int>(type: "int", nullable: false),
                    Pregledana = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_gostiNotifikacije", x => x.Id);
                    table.ForeignKey(
                        name: "FK_gostiNotifikacije_gost_gostID",
                        column: x => x.gostID,
                        principalTable: "gost",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_gostiNotifikacije_notifikacije_notifikacijeId",
                        column: x => x.notifikacijeId,
                        principalTable: "notifikacije",
                        principalColumn: "Id");
                });

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

            migrationBuilder.InsertData(
                table: "Usluga",
                columns: new[] { "UslugaID", "Cijena", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, 10, "Dorucak", "Dorucak u hotelu" },
                    { 2, 15, "Rucak", "Rucak u hotelu" },
                    { 3, 50, "Masaza", "Usluge masaze" },
                    { 4, 75, "Sauna", "Koristenje saune" }
                });

            migrationBuilder.InsertData(
                table: "drzava",
                columns: new[] { "ID", "naziv" },
                values: new object[,]
                {
                    { 1, "Bosna i Hercegovina" },
                    { 2, "Hrvatska" },
                    { 3, "Srbija" }
                });

            migrationBuilder.InsertData(
                table: "osoblje",
                columns: new[] { "ID", "email", "ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "prezime", "Slika", "telefon" },
                values: new object[,]
                {
                    { 1, "adin.smajkic@gmail.com", "adiiiin", "adin1998", "XsHiRH3wqycFCD4pG26l5xPqJgo=", "FnmwHukhLVZJJLzL2Jg8HQ==", "smaajkic", new byte[0], "061981256" },
                    { 2, "haris.tulic@edu.fit.ba", "Haris", "tulatula", "RLkYnZGEW+Otmx0Kn78tQmSLxgk=", "A3bYgzz6F0Yvq/9KStj2oQ==", "Tulic", new byte[0], "0620626" },
                    { 3, "dina.bjelic@gmail.com", "Dina", "dina99", "XsHiRH3wqycFCD4pG26l5xPqJgo=", "A3bYgzz6F0Yvq/9KStj2oQ==", "Bjelic", new byte[0], "062897542" },
                    { 4, "smajo.durakovic@gmail.com", "Smajo", "smajo95", "RLkYnZGEW+Otmx0Kn78tQmSLxgk=", "A3bYgzz6F0Yvq/9KStj2oQ==", "Durakovic", new byte[0], "525521215" }
                });

            migrationBuilder.InsertData(
                table: "sobaStatus",
                columns: new[] { "ID", "opis", "status" },
                values: new object[,]
                {
                    { 1, "Soba Slobodna za rezervisanje", "Slobodna" },
                    { 2, "Soba trenutacno zauzeta", "Zauzeta" }
                });

            migrationBuilder.InsertData(
                table: "vrstaOsoblja",
                columns: new[] { "ID", "pozicija", "zaduzenja" },
                values: new object[,]
                {
                    { 1, "Direktor", "Vodjenje posla i upravljanje ljudima i poslovima" },
                    { 2, "Administracija", "vodjenje hotela i ugovaranje dogadjaja" },
                    { 3, "Recepcionar", "Docekivanje gostiju i davanje svih potrebnih informacija" },
                    { 4, "Spremacica", "Spremanje i ciscenje soba kako bi nasi gosti bili zadovoljni uslugom" }
                });

            migrationBuilder.InsertData(
                table: "grad",
                columns: new[] { "ID", "drzavaID", "nazivGrada", "PostanskiBroj" },
                values: new object[,]
                {
                    { 1, 1, "Mostar", 0 },
                    { 2, 1, "Sarajevo", 0 },
                    { 3, 1, "Tuzla", 0 },
                    { 4, 2, "Zagreb", 0 },
                    { 5, 3, "Beograd", 0 },
                    { 6, 1, "Bihac", 0 }
                });

            migrationBuilder.InsertData(
                table: "novosti",
                columns: new[] { "Id", "DatumObjave", "Naslov", "osobljeID", "Sadrzaj" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 12, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "Akcije za novu godinu", 1, "Docekajte novu godinu u nasem hotelu uz nikad povoljnije cijene" },
                    { 2, new DateTime(2024, 12, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "Svi smjestajni kapaciteti popunjeni", 4, "Prethodni vikend, svi smjestajni kapaciteti bili popunjeni" },
                    { 3, new DateTime(2024, 12, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "Posjeta hotelu", 4, "Nas hotel posjetila reprezentacija Bosne i Hercegovine" }
                });

            migrationBuilder.InsertData(
                table: "osobljeUloge",
                columns: new[] { "OsobljeUlogeID", "DatumIzmjene", "osobljeID", "vrstaOsobljaID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 3 },
                    { 3, new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 4 },
                    { 4, new DateTime(2025, 1, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 3 }
                });

            migrationBuilder.InsertData(
                table: "soba",
                columns: new[] { "ID", "BrojSobe", "BrojSprata", "opisSobe", "PictureName", "PicturePath", "Slika", "sobaStatusID" },
                values: new object[,]
                {
                    { 1, 1, 1, "Soba u tisini", null, null, new byte[0], 1 },
                    { 2, 2, 1, "Soba u tisini", null, null, new byte[0], 1 },
                    { 3, 3, 1, "Soba s pogledom na more", null, null, new byte[0], 2 },
                    { 4, 4, 2, "Soba s pogledom na cijeli grad", null, null, new byte[0], 1 }
                });

            migrationBuilder.InsertData(
                table: "gost",
                columns: new[] { "ID", "email", "gradID", "ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "prezime", "telefon" },
                values: new object[,]
                {
                    { 1, "adin.smajkic@gmail.com", 1, "Adin", "adin1998", "ZG+m4HIibaJpXMVrtXhp9+QQiDE=", "8yGM2clNjUvFcuobbcqRSg==", "Smajkic", "5842521" },
                    { 2, "ahmed.sm@gmail.com", 2, "ahmed", "ahmo", "57dqXte2i8RuxpISQMzOjW/kYUA=", "uSHCckjLFYgVNJRSWd2W5g==", "smajic", "062263580" },
                    { 3, "novikorisnk.test@gmail.com", 3, "test", "test98", "nEE+3SNUp4E2UX5xfPGpH6R+ELA=", "uFdyLQoAo6+BtcRfOYC0Og==", "novi korisnik", "52515215" },
                    { 4, "dd.ss@gmail.com", 1, "aaaa", "aadd", "TPBs9dFgTsf0SmZpnSfQcmyIISE=", "cJCHfu17NRuIYzB3bS9onw==", "dddd", "43743743" },
                    { 5, "huso.smajkic@gmail.com", 4, "huso", "huso55", "cLhzBmLT6jPfLssPnXTSFOLBehw=", "uy9mahnWC7AvJIt+6qeWPg==", "smajkic", "1234214" }
                });

            migrationBuilder.InsertData(
                table: "sobaOsoblje",
                columns: new[] { "ID", "osobljeID", "sobaID" },
                values: new object[,]
                {
                    { 1, 4, 1 },
                    { 2, 4, 2 },
                    { 3, 4, 3 },
                    { 4, 4, 4 }
                });

            migrationBuilder.InsertData(
                table: "recenzija",
                columns: new[] { "ID", "gostID", "komentar", "ocjena", "sobaID" },
                values: new object[,]
                {
                    { 1, 1, "Prezadovoljan hotelom i uslugom", 10, 1 },
                    { 2, 2, "Hrana nije bila bas najbolja", 8, 2 },
                    { 3, 3, "Sve preporuke za ovaj hotel", 9, 2 },
                    { 4, 4, "Prezadovoljan sa svim", 10, 3 }
                });

            migrationBuilder.InsertData(
                table: "rezervacija",
                columns: new[] { "ID", "Cijena", "datumRezervacije", "gostID", "Otkazana", "Qrcode", "sobaID", "zavrsetakRezervacije" },
                values: new object[,]
                {
                    { 1, 305f, new DateTime(2024, 12, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, null, null, 1, new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, 295f, new DateTime(2024, 12, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, 1, new DateTime(2024, 12, 29, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, 215f, new DateTime(2024, 12, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, null, null, 2, new DateTime(2024, 12, 14, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, 350f, new DateTime(2024, 12, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, null, null, 3, new DateTime(2024, 12, 4, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "RezervacijaUsluga",
                columns: new[] { "RezervacijaUslugaID", "RezervacijaID", "UslugaId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 1, 2 },
                    { 3, 1, 4 },
                    { 4, 2, 3 },
                    { 5, 3, 4 },
                    { 6, 3, 2 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_cjenovnik_sobaID",
                table: "cjenovnik",
                column: "sobaID");

            migrationBuilder.CreateIndex(
                name: "IX_gost_gradID",
                table: "gost",
                column: "gradID");

            migrationBuilder.CreateIndex(
                name: "IX_gostiNotifikacije_gostID",
                table: "gostiNotifikacije",
                column: "gostID");

            migrationBuilder.CreateIndex(
                name: "IX_gostiNotifikacije_notifikacijeId",
                table: "gostiNotifikacije",
                column: "notifikacijeId");

            migrationBuilder.CreateIndex(
                name: "IX_grad_drzavaID",
                table: "grad",
                column: "drzavaID");

            migrationBuilder.CreateIndex(
                name: "IX_notifikacije_NovostId",
                table: "notifikacije",
                column: "NovostId");

            migrationBuilder.CreateIndex(
                name: "IX_novosti_osobljeID",
                table: "novosti",
                column: "osobljeID");

            migrationBuilder.CreateIndex(
                name: "IX_osobljeUloge_osobljeID",
                table: "osobljeUloge",
                column: "osobljeID");

            migrationBuilder.CreateIndex(
                name: "IX_osobljeUloge_vrstaOsobljaID",
                table: "osobljeUloge",
                column: "vrstaOsobljaID");

            migrationBuilder.CreateIndex(
                name: "IX_recenzija_gostID",
                table: "recenzija",
                column: "gostID");

            migrationBuilder.CreateIndex(
                name: "IX_recenzija_sobaID",
                table: "recenzija",
                column: "sobaID");

            migrationBuilder.CreateIndex(
                name: "IX_rezervacija_gostID",
                table: "rezervacija",
                column: "gostID");

            migrationBuilder.CreateIndex(
                name: "IX_rezervacija_sobaID",
                table: "rezervacija",
                column: "sobaID");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluga_RezervacijaID",
                table: "RezervacijaUsluga",
                column: "RezervacijaID");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluga_UslugaId",
                table: "RezervacijaUsluga",
                column: "UslugaId");

            migrationBuilder.CreateIndex(
                name: "IX_soba_sobaStatusID",
                table: "soba",
                column: "sobaStatusID");

            migrationBuilder.CreateIndex(
                name: "IX_sobaOsoblje_osobljeID",
                table: "sobaOsoblje",
                column: "osobljeID");

            migrationBuilder.CreateIndex(
                name: "IX_sobaOsoblje_sobaID",
                table: "sobaOsoblje",
                column: "sobaID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "cjenovnik");

            migrationBuilder.DropTable(
                name: "gostiNotifikacije");

            migrationBuilder.DropTable(
                name: "osobljeUloge");

            migrationBuilder.DropTable(
                name: "recenzija");

            migrationBuilder.DropTable(
                name: "RezervacijaUsluga");

            migrationBuilder.DropTable(
                name: "sobaOsoblje");

            migrationBuilder.DropTable(
                name: "notifikacije");

            migrationBuilder.DropTable(
                name: "vrstaOsoblja");

            migrationBuilder.DropTable(
                name: "rezervacija");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "novosti");

            migrationBuilder.DropTable(
                name: "gost");

            migrationBuilder.DropTable(
                name: "soba");

            migrationBuilder.DropTable(
                name: "osoblje");

            migrationBuilder.DropTable(
                name: "grad");

            migrationBuilder.DropTable(
                name: "sobaStatus");

            migrationBuilder.DropTable(
                name: "drzava");
        }
    }
}
