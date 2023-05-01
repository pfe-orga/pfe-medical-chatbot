using Microsoft.AspNetCore.Authentication;

namespace Pfe.ChatbotApi.Dto
{
    public class Login
    {   public int id { get; set; }
        public String Email { get; set; }
        public String Password { get; set; }
        public string? Provider { get; set; }
        //public string ReturnUrl { get; internal set; }
        //public List<AuthenticationScheme> ExternalLogins { get; internal set; }
        //public bool RememberMe { get; internal set; }
    }
}
