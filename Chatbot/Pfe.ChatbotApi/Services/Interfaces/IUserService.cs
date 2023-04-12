using Pfe.ChatbotApi.Core;

namespace Pfe.ChatbotApi.Services.Interfaces
{
    public interface IUserService
    {
        Task<User> AddUserAsync(User user);
        Task<User> DeleteUserAsync(int Id);
        Task<User> UpdateUserAsync(User user);

        List<User> List();
        
    }
}
