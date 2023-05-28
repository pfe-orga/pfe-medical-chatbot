using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pfe.ChatbotApi.Core
{
    [Table("GeoLocs")]
    public class GeoLocation
    {
        [Key, Required]
        public int id { get; set; }
        public String names { get; set; }

        public String place { get; set; }

        public String numero { get; set; }


    }
}
