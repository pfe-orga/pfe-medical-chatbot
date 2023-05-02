using Pfe.ChatbotApi.Core;
using System.Security.Claims;
using System.Text.Json.Serialization;

namespace Pfe.ChatbotApi.Services
{
    public class IdentityService
    {
        public ConnectedUser ConnectedUser { get; set; }
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly DataContext _dataContext;
        public IdentityService(IHttpContextAccessor httpContextAccessor, DataContext dataContext)
        {
            _httpContextAccessor = httpContextAccessor;
            _dataContext = dataContext;

            if (_httpContextAccessor.HttpContext.User.Identity.IsAuthenticated)
            {
                var email = _httpContextAccessor.HttpContext.User.Claims.First(x => x.Type == ClaimTypes.NameIdentifier).Value;
                var bdUser = _dataContext.Users.FirstOrDefault(x => x.Email.Equals(email));
                ConnectedUser = new ConnectedUser
                {
                    Email = email,
                    Name = bdUser.Name,
                    Password = bdUser.Password,
                    Role = bdUser.Role

                };
            }

        }
    }
    public class ConnectedUser
    {
        public string Name { get; set; }
        [JsonIgnore]
        public string Password { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }

    }
}
