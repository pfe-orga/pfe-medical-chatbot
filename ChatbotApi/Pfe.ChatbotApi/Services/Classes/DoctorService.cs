using Microsoft.EntityFrameworkCore;
using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Services.Interfaces;

namespace Pfe.ChatbotApi.Services.Classes
{
    public class DoctorService : IUserService
    {
        private readonly DataContext _dataContext;
        public DoctorService(DataContext dataContext)
        {
            _dataContext = dataContext;
        }
        public async Task<User> AddUserAsync(User user)
        {
            throw new NotImplementedException();

        }


        public Task<User> DeleteUserAsync(int Id)
        {
            throw new NotImplementedException();
        }

        public async Task<String> GetUserAsync(int Id)
        {
            var user = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == Id) ?? throw new Exception("user not found");
            String result = "Name: " + user.Name + "/n Email:" + user.Email;
            return result;
        }

        public List<User> List()
        {
            throw new NotImplementedException();
        }

        public Task<User> UpdateUserAsync(User user)
        {
            throw new NotImplementedException();
        }

        Task<User> IUserService.GetUserAsync(int Id)
        {
            throw new NotImplementedException();
        }
    }
}
