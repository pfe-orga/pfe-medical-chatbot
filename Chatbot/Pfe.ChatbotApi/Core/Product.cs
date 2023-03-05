using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("product")]
    public class Product
    {
        [Key, Required]
        public int Id { get; set; }
        public int Name { get; set; }
        public int Brand { get; set; }
        public int Size  { get; set; }
        public int Price { get; set; }
    }
}
