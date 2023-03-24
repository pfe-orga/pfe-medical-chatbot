using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Services.Classes
{
    [Table("Users")]
    public class User
    {

        [Key, Required]
         [DatabaseGenerated(DatabaseGeneratedOption.Identity)]

        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
    }
    
}
