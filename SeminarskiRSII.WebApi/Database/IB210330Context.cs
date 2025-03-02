using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using SeminarskiRSII.WebApi.Database.DataSeed;

namespace SeminarskiRSII.WebApi.Database
{
    public partial class IB210330Context : DbContext
    {
        public IB210330Context()
        {
        }

        public IB210330Context(DbContextOptions<IB210330Context> options)
            : base(options)
        {
        }

        public virtual DbSet<Cjenovnik> Cjenovnik { get; set; } = null!;
        public virtual DbSet<Drzava> Drzava { get; set; } = null!;
        public virtual DbSet<Gost> Gost { get; set; } = null!;
        public virtual DbSet<GostiNotifikacije> GostiNotifikacije { get; set; } = null!;
        public virtual DbSet<Grad> Grad { get; set; } = null!;
        public virtual DbSet<Notifikacije> Notifikacije { get; set; } = null!;
        public virtual DbSet<Novosti> Novosti { get; set; } = null!;
        public virtual DbSet<Osoblje> Osoblje { get; set; } = null!;
        public virtual DbSet<OsobljeUloge> OsobljeUloge { get; set; } = null!;
        public virtual DbSet<Recenzija> Recenzija { get; set; } = null!;
        public virtual DbSet<Rezervacija> Rezervacija { get; set; } = null!;
        public virtual DbSet<Soba> Soba { get; set; } = null!;
        public virtual DbSet<SobaOsoblje> SobaOsoblje { get; set; } = null!;
        public virtual DbSet<SobaStatus> SobaStatus { get; set; } = null!;
        public virtual DbSet<VrstaOsoblja> VrstaOsoblja { get; set; } = null!;
        public virtual DbSet<Usluga> Usluga { get; set; }
        public virtual DbSet<RezervacijaUsluga> RezervacijaUsluga { get; set; }


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=.;Database=IB210330;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Cjenovnik>(entity =>
            {
                entity.ToTable("cjenovnik");

                entity.HasIndex(e => e.SobaId, "IX_cjenovnik_sobaID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Cijena).HasColumnName("cijena");

                entity.Property(e => e.SobaId).HasColumnName("sobaID");

                entity.HasOne(d => d.Soba)
                    .WithMany(p => p.Cjenovnik)
                    .HasForeignKey(d => d.SobaId);
            });

            modelBuilder.Entity<Drzava>(entity =>
            {
                entity.ToTable("drzava");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Naziv).HasColumnName("naziv");
            });

            modelBuilder.Entity<Gost>(entity =>
            {
                entity.ToTable("gost");

                entity.HasIndex(e => e.GradId, "IX_gost_gradID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.GradId).HasColumnName("gradID");

                entity.Property(e => e.Ime).HasColumnName("ime");

                entity.Property(e => e.Prezime).HasColumnName("prezime");

                entity.Property(e => e.Telefon).HasColumnName("telefon");

                entity.HasOne(d => d.Grad)
                    .WithMany(p => p.Gost)
                    .HasForeignKey(d => d.GradId);
            });

            modelBuilder.Entity<GostiNotifikacije>(entity =>
            {
                entity.ToTable("gostiNotifikacije");

                entity.HasIndex(e => e.GostId, "IX_gostiNotifikacije_gostID");

                entity.HasIndex(e => e.NotifikacijeId, "IX_gostiNotifikacije_notifikacijeId");

                entity.Property(e => e.GostId).HasColumnName("gostID");

                entity.Property(e => e.NotifikacijeId).HasColumnName("notifikacijeId");

                entity.HasOne(d => d.Gost)
                    .WithMany(p => p.GostiNotifikacije)
                    .HasForeignKey(d => d.GostId);

                entity.HasOne(d => d.Notifikacije)
                    .WithMany(p => p.GostiNotifikacije)
                    .HasForeignKey(d => d.NotifikacijeId);
            });

            modelBuilder.Entity<Grad>(entity =>
            {
                entity.ToTable("grad");

                entity.HasIndex(e => e.DrzavaId, "IX_grad_drzavaID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DrzavaId).HasColumnName("drzavaID");

                entity.Property(e => e.NazivGrada).HasColumnName("nazivGrada");

                entity.HasOne(d => d.Drzava)
                    .WithMany(p => p.Grad)
                    .HasForeignKey(d => d.DrzavaId);
            });

            modelBuilder.Entity<Notifikacije>(entity =>
            {
                entity.ToTable("notifikacije");

                entity.HasIndex(e => e.NovostId, "IX_notifikacije_NovostId");

                entity.HasOne(d => d.Novost)
                    .WithMany(p => p.Notifikacije)
                    .HasForeignKey(d => d.NovostId);
            });

            modelBuilder.Entity<Novosti>(entity =>
            {
                entity.ToTable("novosti");

                entity.HasIndex(e => e.OsobljeId, "IX_novosti_osobljeID");

                entity.Property(e => e.OsobljeId).HasColumnName("osobljeID");

                entity.HasOne(d => d.Osoblje)
                    .WithMany(p => p.Novosti)
                    .HasForeignKey(d => d.OsobljeId);
            });

            modelBuilder.Entity<Osoblje>(entity =>
            {
                entity.ToTable("osoblje");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.Ime).HasColumnName("ime");

                entity.Property(e => e.Prezime).HasColumnName("prezime");

                entity.Property(e => e.Telefon).HasColumnName("telefon");
            });

            modelBuilder.Entity<OsobljeUloge>(entity =>
            {
                entity.ToTable("osobljeUloge");

                entity.HasIndex(e => e.OsobljeId, "IX_osobljeUloge_osobljeID");

                entity.HasIndex(e => e.VrstaOsobljaId, "IX_osobljeUloge_vrstaOsobljaID");

                entity.Property(e => e.OsobljeUlogeId).HasColumnName("OsobljeUlogeID");

                entity.Property(e => e.OsobljeId).HasColumnName("osobljeID");

                entity.Property(e => e.VrstaOsobljaId).HasColumnName("vrstaOsobljaID");

                entity.HasOne(d => d.Osoblje)
                    .WithMany(p => p.OsobljeUloge)
                    .HasForeignKey(d => d.OsobljeId);

                entity.HasOne(d => d.VrstaOsoblja)
                    .WithMany(p => p.OsobljeUloge)
                    .HasForeignKey(d => d.VrstaOsobljaId);
            });

            modelBuilder.Entity<Recenzija>(entity =>
            {
                entity.ToTable("recenzija");

                entity.HasIndex(e => e.GostId, "IX_recenzija_gostID");

                entity.HasIndex(e => e.SobaId, "IX_recenzija_sobaID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.GostId).HasColumnName("gostID");

                entity.Property(e => e.Komentar).HasColumnName("komentar");

                entity.Property(e => e.Ocjena).HasColumnName("ocjena");

                entity.Property(e => e.SobaId).HasColumnName("sobaID");

                entity.HasOne(d => d.Gost)
                    .WithMany(p => p.Recenzija)
                    .HasForeignKey(d => d.GostId);

                entity.HasOne(d => d.Soba)
                    .WithMany(p => p.Recenzija)
                    .HasForeignKey(d => d.SobaId);
            });

            modelBuilder.Entity<Rezervacija>(entity =>
            {
                entity.ToTable("rezervacija");

                entity.HasIndex(e => e.GostId, "IX_rezervacija_gostID");

                entity.HasIndex(e => e.SobaId, "IX_rezervacija_sobaID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.DatumRezervacije).HasColumnName("datumRezervacije");

                entity.Property(e => e.GostId).HasColumnName("gostID");

                entity.Property(e => e.SobaId).HasColumnName("sobaID");

                entity.Property(e => e.ZavrsetakRezervacije).HasColumnName("zavrsetakRezervacije");

                entity.HasOne(d => d.Gost)
                    .WithMany(p => p.Rezervacija)
                    .HasForeignKey(d => d.GostId);

                entity.HasOne(d => d.Soba)
                    .WithMany(p => p.Rezervacija)
                    .HasForeignKey(d => d.SobaId);
            });

            modelBuilder.Entity<Soba>(entity =>
            {
                entity.ToTable("soba");

                entity.HasIndex(e => e.SobaStatusId, "IX_soba_sobaStatusID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.OpisSobe).HasColumnName("opisSobe");

                entity.Property(e => e.SobaStatusId).HasColumnName("sobaStatusID");

                entity.HasOne(d => d.SobaStatus)
                    .WithMany(p => p.Soba)
                    .HasForeignKey(d => d.SobaStatusId);
            });

            modelBuilder.Entity<SobaOsoblje>(entity =>
            {
                entity.ToTable("sobaOsoblje");

                entity.HasIndex(e => e.OsobljeId, "IX_sobaOsoblje_osobljeID");

                entity.HasIndex(e => e.SobaId, "IX_sobaOsoblje_sobaID");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.OsobljeId).HasColumnName("osobljeID");

                entity.Property(e => e.SobaId).HasColumnName("sobaID");

                entity.HasOne(d => d.Osoblje)
                    .WithMany(p => p.SobaOsoblje)
                    .HasForeignKey(d => d.OsobljeId);

                entity.HasOne(d => d.Soba)
                    .WithMany(p => p.SobaOsoblje)
                    .HasForeignKey(d => d.SobaId);
            });

            modelBuilder.Entity<SobaStatus>(entity =>
            {
                entity.ToTable("sobaStatus");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Opis).HasColumnName("opis");

                entity.Property(e => e.Status).HasColumnName("status");
            });

            modelBuilder.Entity<VrstaOsoblja>(entity =>
            {
                entity.ToTable("vrstaOsoblja");

                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.Pozicija).HasColumnName("pozicija");

                entity.Property(e => e.Zaduzenja).HasColumnName("zaduzenja");
            });

            modelBuilder.SeedCjenovnik();
            modelBuilder.SeedDrzava();
            modelBuilder.SeedGrad();
            modelBuilder.SeedUsluga();
            modelBuilder.SeedSobaStatus();
            modelBuilder.SeedVrstaOsoblja();
            modelBuilder.SeedGost();
            modelBuilder.SeedSoba();
            modelBuilder.SeedOsoblje();
            modelBuilder.SeedOsobljeUloge();
            modelBuilder.SeedSobaOsoblje();
            modelBuilder.SeedNovosti();
            modelBuilder.SeedRezervacija();
            modelBuilder.SeedRecenzija();
            modelBuilder.SeedRezervacijaUsluga();

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
