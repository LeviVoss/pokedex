namespace PokeDex_lvoss.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class PokeEDMX : DbContext
    {
        public PokeEDMX()
            : base("name=PokeEDMX")
        {
        }

        public virtual DbSet<Pokemon> Pokemons { get; set; }
        public virtual DbSet<Type> Types { get; set; }
        public virtual DbSet<PokemonHint> PokemonHints { get; set; }
        
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Pokemon>()
                .Property(e => e.height)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.weight)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.gender)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.category)
                .IsUnicode(false);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.pokeImgName)
                .IsUnicode(false);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.evolution);

            modelBuilder.Entity<Pokemon>()
                .Property(e => e.maxEvo);

            modelBuilder.Entity<Type>()
                .Property(e => e.typeName)
                .IsUnicode(false);

            modelBuilder.Entity<Type>()
                .Property(e => e.typeImg)
                .IsUnicode(false);
        }
    }
}
