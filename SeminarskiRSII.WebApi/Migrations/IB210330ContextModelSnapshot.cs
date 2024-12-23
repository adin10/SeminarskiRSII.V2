﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using SeminarskiRSII.WebApi.Database;

#nullable disable

namespace SeminarskiRSII.WebApi.Migrations
{
    [DbContext(typeof(IB210330Context))]
    partial class IB210330ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.11")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Cjenovnik", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<float>("Cijena")
                        .HasColumnType("real")
                        .HasColumnName("cijena");

                    b.Property<int>("SobaId")
                        .HasColumnType("int")
                        .HasColumnName("sobaID");

                    b.Property<string>("Valuta")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "SobaId" }, "IX_cjenovnik_sobaID");

                    b.ToTable("cjenovnik", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Drzava", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Naziv")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("naziv");

                    b.HasKey("Id");

                    b.ToTable("drzava", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Gost", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("email");

                    b.Property<int>("GradId")
                        .HasColumnType("int")
                        .HasColumnName("gradID");

                    b.Property<string>("Ime")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("ime");

                    b.Property<string>("KorisnickoIme")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaSalt")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Prezime")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("prezime");

                    b.Property<string>("Telefon")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("telefon");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "GradId" }, "IX_gost_gradID");

                    b.ToTable("gost", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.GostiNotifikacije", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("GostId")
                        .HasColumnType("int")
                        .HasColumnName("gostID");

                    b.Property<int?>("NotifikacijeId")
                        .HasColumnType("int")
                        .HasColumnName("notifikacijeId");

                    b.Property<bool>("Pregledana")
                        .HasColumnType("bit");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "GostId" }, "IX_gostiNotifikacije_gostID");

                    b.HasIndex(new[] { "NotifikacijeId" }, "IX_gostiNotifikacije_notifikacijeId");

                    b.ToTable("gostiNotifikacije", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Grad", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("DrzavaId")
                        .HasColumnType("int")
                        .HasColumnName("drzavaID");

                    b.Property<string>("NazivGrada")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("nazivGrada");

                    b.Property<int>("PostanskiBroj")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "DrzavaId" }, "IX_grad_drzavaID");

                    b.ToTable("grad", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Notifikacije", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<DateTime>("DatumSlanja")
                        .HasColumnType("datetime2");

                    b.Property<string>("Naslov")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("NovostId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "NovostId" }, "IX_notifikacije_NovostId");

                    b.ToTable("notifikacije", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Novosti", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<DateTime?>("DatumObjave")
                        .HasColumnType("datetime2");

                    b.Property<string>("Naslov")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("OsobljeId")
                        .HasColumnType("int")
                        .HasColumnName("osobljeID");

                    b.Property<string>("Sadrzaj")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "OsobljeId" }, "IX_novosti_osobljeID");

                    b.ToTable("novosti", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Osoblje", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("email");

                    b.Property<string>("Ime")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("ime");

                    b.Property<string>("KorisnickoIme")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaSalt")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Prezime")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("prezime");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Telefon")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("telefon");

                    b.HasKey("Id");

                    b.ToTable("osoblje", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.OsobljeUloge", b =>
                {
                    b.Property<int>("OsobljeUlogeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("OsobljeUlogeID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("OsobljeUlogeId"), 1L, 1);

                    b.Property<DateTime>("DatumIzmjene")
                        .HasColumnType("datetime2");

                    b.Property<int>("OsobljeId")
                        .HasColumnType("int")
                        .HasColumnName("osobljeID");

                    b.Property<int>("VrstaOsobljaId")
                        .HasColumnType("int")
                        .HasColumnName("vrstaOsobljaID");

                    b.HasKey("OsobljeUlogeId");

                    b.HasIndex(new[] { "OsobljeId" }, "IX_osobljeUloge_osobljeID");

                    b.HasIndex(new[] { "VrstaOsobljaId" }, "IX_osobljeUloge_vrstaOsobljaID");

                    b.ToTable("osobljeUloge", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Recenzija", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("GostId")
                        .HasColumnType("int")
                        .HasColumnName("gostID");

                    b.Property<string>("Komentar")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("komentar");

                    b.Property<int>("Ocjena")
                        .HasColumnType("int")
                        .HasColumnName("ocjena");

                    b.Property<int>("SobaId")
                        .HasColumnType("int")
                        .HasColumnName("sobaID");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "GostId" }, "IX_recenzija_gostID");

                    b.HasIndex(new[] { "SobaId" }, "IX_recenzija_sobaID");

                    b.ToTable("recenzija", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Rezervacija", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<float>("Cijena")
                        .HasColumnType("real");

                    b.Property<DateTime>("DatumRezervacije")
                        .HasColumnType("datetime2")
                        .HasColumnName("datumRezervacije");

                    b.Property<int>("GostId")
                        .HasColumnType("int")
                        .HasColumnName("gostID");

                    b.Property<bool?>("Otkazana")
                        .HasColumnType("bit");

                    b.Property<byte[]>("Qrcode")
                        .HasColumnType("varbinary(max)");

                    b.Property<int>("SobaId")
                        .HasColumnType("int")
                        .HasColumnName("sobaID");

                    b.Property<DateTime>("ZavrsetakRezervacije")
                        .HasColumnType("datetime2")
                        .HasColumnName("zavrsetakRezervacije");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "GostId" }, "IX_rezervacija_gostID");

                    b.HasIndex(new[] { "SobaId" }, "IX_rezervacija_sobaID");

                    b.ToTable("rezervacija", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.RezervacijaUsluga", b =>
                {
                    b.Property<int>("RezervacijaUslugaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RezervacijaUslugaID"), 1L, 1);

                    b.Property<int?>("RezervacijaID")
                        .HasColumnType("int");

                    b.Property<int?>("UslugaId")
                        .HasColumnType("int");

                    b.HasKey("RezervacijaUslugaID");

                    b.HasIndex("RezervacijaID");

                    b.HasIndex("UslugaId");

                    b.ToTable("RezervacijaUsluga");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Soba", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("BrojSobe")
                        .HasColumnType("int");

                    b.Property<int>("BrojSprata")
                        .HasColumnType("int");

                    b.Property<string>("OpisSobe")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("opisSobe");

                    b.Property<string>("PictureName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PicturePath")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<int>("SobaStatusId")
                        .HasColumnType("int")
                        .HasColumnName("sobaStatusID");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "SobaStatusId" }, "IX_soba_sobaStatusID");

                    b.ToTable("soba", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.SobaOsoblje", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("OsobljeId")
                        .HasColumnType("int")
                        .HasColumnName("osobljeID");

                    b.Property<int>("SobaId")
                        .HasColumnType("int")
                        .HasColumnName("sobaID");

                    b.HasKey("Id");

                    b.HasIndex(new[] { "OsobljeId" }, "IX_sobaOsoblje_osobljeID");

                    b.HasIndex(new[] { "SobaId" }, "IX_sobaOsoblje_sobaID");

                    b.ToTable("sobaOsoblje", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.SobaStatus", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Opis")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("opis");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("status");

                    b.HasKey("Id");

                    b.ToTable("sobaStatus", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Usluga", b =>
                {
                    b.Property<int>("UslugaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UslugaID"), 1L, 1);

                    b.Property<int>("Cijena")
                        .HasColumnType("int");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UslugaID");

                    b.ToTable("Usluga");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.VrstaOsoblja", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Pozicija")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("pozicija");

                    b.Property<string>("Zaduzenja")
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("zaduzenja");

                    b.HasKey("Id");

                    b.ToTable("vrstaOsoblja", (string)null);
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Cjenovnik", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Soba", "Soba")
                        .WithMany("Cjenovnik")
                        .HasForeignKey("SobaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Soba");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Gost", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Grad", "Grad")
                        .WithMany("Gost")
                        .HasForeignKey("GradId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Grad");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.GostiNotifikacije", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Gost", "Gost")
                        .WithMany("GostiNotifikacije")
                        .HasForeignKey("GostId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SeminarskiRSII.WebApi.Database.Notifikacije", "Notifikacije")
                        .WithMany("GostiNotifikacije")
                        .HasForeignKey("NotifikacijeId");

                    b.Navigation("Gost");

                    b.Navigation("Notifikacije");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Grad", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Drzava", "Drzava")
                        .WithMany("Grad")
                        .HasForeignKey("DrzavaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Drzava");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Notifikacije", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Novosti", "Novost")
                        .WithMany("Notifikacije")
                        .HasForeignKey("NovostId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Novost");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Novosti", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Osoblje", "Osoblje")
                        .WithMany("Novosti")
                        .HasForeignKey("OsobljeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Osoblje");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.OsobljeUloge", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Osoblje", "Osoblje")
                        .WithMany("OsobljeUloge")
                        .HasForeignKey("OsobljeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SeminarskiRSII.WebApi.Database.VrstaOsoblja", "VrstaOsoblja")
                        .WithMany("OsobljeUloge")
                        .HasForeignKey("VrstaOsobljaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Osoblje");

                    b.Navigation("VrstaOsoblja");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Recenzija", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Gost", "Gost")
                        .WithMany("Recenzija")
                        .HasForeignKey("GostId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SeminarskiRSII.WebApi.Database.Soba", "Soba")
                        .WithMany("Recenzija")
                        .HasForeignKey("SobaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Gost");

                    b.Navigation("Soba");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Rezervacija", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Gost", "Gost")
                        .WithMany("Rezervacija")
                        .HasForeignKey("GostId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SeminarskiRSII.WebApi.Database.Soba", "Soba")
                        .WithMany("Rezervacija")
                        .HasForeignKey("SobaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Gost");

                    b.Navigation("Soba");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.RezervacijaUsluga", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Rezervacija", "Rezervacija")
                        .WithMany("RezervacijaUsluge")
                        .HasForeignKey("RezervacijaID");

                    b.HasOne("SeminarskiRSII.WebApi.Database.Usluga", "Usluga")
                        .WithMany("RezervacijaUsluge")
                        .HasForeignKey("UslugaId");

                    b.Navigation("Rezervacija");

                    b.Navigation("Usluga");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Soba", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.SobaStatus", "SobaStatus")
                        .WithMany("Soba")
                        .HasForeignKey("SobaStatusId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("SobaStatus");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.SobaOsoblje", b =>
                {
                    b.HasOne("SeminarskiRSII.WebApi.Database.Osoblje", "Osoblje")
                        .WithMany("SobaOsoblje")
                        .HasForeignKey("OsobljeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SeminarskiRSII.WebApi.Database.Soba", "Soba")
                        .WithMany("SobaOsoblje")
                        .HasForeignKey("SobaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Osoblje");

                    b.Navigation("Soba");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Drzava", b =>
                {
                    b.Navigation("Grad");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Gost", b =>
                {
                    b.Navigation("GostiNotifikacije");

                    b.Navigation("Recenzija");

                    b.Navigation("Rezervacija");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Grad", b =>
                {
                    b.Navigation("Gost");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Notifikacije", b =>
                {
                    b.Navigation("GostiNotifikacije");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Novosti", b =>
                {
                    b.Navigation("Notifikacije");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Osoblje", b =>
                {
                    b.Navigation("Novosti");

                    b.Navigation("OsobljeUloge");

                    b.Navigation("SobaOsoblje");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Rezervacija", b =>
                {
                    b.Navigation("RezervacijaUsluge");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Soba", b =>
                {
                    b.Navigation("Cjenovnik");

                    b.Navigation("Recenzija");

                    b.Navigation("Rezervacija");

                    b.Navigation("SobaOsoblje");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.SobaStatus", b =>
                {
                    b.Navigation("Soba");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.Usluga", b =>
                {
                    b.Navigation("RezervacijaUsluge");
                });

            modelBuilder.Entity("SeminarskiRSII.WebApi.Database.VrstaOsoblja", b =>
                {
                    b.Navigation("OsobljeUloge");
                });
#pragma warning restore 612, 618
        }
    }
}
