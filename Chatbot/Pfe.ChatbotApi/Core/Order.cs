using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("order")]
    public class Order
    {
        [Key, Required]
        public int Id { get; set; }
        public int prodfuct_Id { get; set; }
        public virtual Product Product { get; set; }
        public string name { get; set; } = string.Empty;
        public string adress { get; set; } = string.Empty;
        public string phone { get; set; } = string.Empty;


    }
}
