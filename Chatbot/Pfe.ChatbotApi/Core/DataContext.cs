using Microsoft.EntityFrameworkCore;

namespace Pfe.ChatbotApi.Core
{
    public class DataContext : DbContext   
    {   
        public DataContext(DbContextOptions<DataContext> options): base(options) { }
        
        public DbSet<Product> Products { get; set; }
        public DbSet<Order> Orders { get; set; }
    }
}
