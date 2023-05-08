namespace Pfe.ChatbotApi.Core
{
    public class UserRequest
    {
        public required String Name { get; set; } 
        public required String Email { get; set; } 
        public required String Password { get; set; }
        public required Roles role { get; set; }

    }
}
