using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace SeminarskiRSII.WebApiDodatni.Database
{
    public class IB210330Context : DbContext
    {
        public IB210330Context(DbContextOptions<IB210330Context> options) : base(options)
        {
        }
        public virtual DbSet<Recenzija> Recenzija { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=.;Database=IB210330_V3;Trusted_Connection=True;");
            }
        }

        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Recenzija>().ToTable("recenzija"); // Ensure this matches your database table name
        //}

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Recenzija>(entity =>
            {
                entity.ToTable("recenzija");

                entity.Property(e => e.Id).HasColumnName("ID");
                entity.Property(e => e.GostId).HasColumnName("gostID");
                entity.Property(e => e.Komentar).HasColumnName("komentar");
                entity.Property(e => e.Ocjena).HasColumnName("ocjena");
                entity.Property(e => e.SobaId).HasColumnName("sobaID");
            });
        }
    }
}
