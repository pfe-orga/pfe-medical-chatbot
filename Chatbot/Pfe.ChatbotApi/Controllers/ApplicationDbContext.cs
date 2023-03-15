using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pfe.ChatbotApi.Services.Classes;

namespace Pfe.ChatbotApi.Controllers
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
    }

    
}
