using Microsoft.EntityFrameworkCore;

namespace Pfe.ChatbotApi.Core
{
    public class DataContext : DbContext   
    {   
        public DataContext(DbContextOptions<DataContext> options): base(options) { }
        
        public DbSet<User> Users { get; set; }
        public object UpdateUser { get; internal set; }
    }
}
