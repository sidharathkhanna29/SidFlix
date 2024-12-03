using Microsoft.EntityFrameworkCore;

namespace MovieList.Models
{
    public class UserContext : DbContext
    {
        public UserContext(DbContextOptions<UserContext> options)
            : base(options)
        { }

        public DbSet<Users> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Users>().HasData(
                new Users { Id = 1, Name = "Sidharath Khanna", Email = "khannasidharath@gmail.com", Bio = "Movie enthusiast." },
                new Users { Id = 2, Name = "Cryston Heaven", Email = "rebootthemodem@gmail.com", Bio = "Loves Sci-fi and action movies." }
            );
        }
    }
}
