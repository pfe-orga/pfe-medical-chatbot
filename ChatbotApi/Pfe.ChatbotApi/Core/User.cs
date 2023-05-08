using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("user")]
    public class User
    {
        internal readonly object password;

        [Key, Required]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required]
        public String Name { get; set; } = string .Empty;
        [Required]
        public String Email { get; set; } = string.Empty;
        [Required]
        public String Password { get; set; } = string.Empty;
        [Required]
        public Roles role { get; set; }
        
    }
}
