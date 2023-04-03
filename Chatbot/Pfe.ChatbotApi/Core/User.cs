using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("user")]
    public class User
    {
        [Key, Required]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public String Name { get; set; } = string .Empty;
        public String Email { get; set; } = string.Empty; 
        public String Password { get; set; } = string.Empty;
        
    }
}
