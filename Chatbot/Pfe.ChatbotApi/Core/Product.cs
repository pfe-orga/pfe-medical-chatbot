using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("product")]
    public class Product
    {
        [Key, Required]
        public int Id { get; set; }
        public int name { get; set; }
        public int brand { get; set; }
        public int size { get; set; }
        public int price { get; set; }
    }
}
