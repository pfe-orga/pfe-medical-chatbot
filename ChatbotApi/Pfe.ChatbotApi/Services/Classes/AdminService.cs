using Microsoft.EntityFrameworkCore;
using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Services.Interfaces;
using System.Collections.Generic;

namespace Pfe.ChatbotApi.Services.Classes
{
    public class AdminService : IUserService
    {
        private readonly DataContext _dataContext;
        public AdminService(DataContext dataContext)
        {
            _dataContext = dataContext;
        }
        public async Task<User> AddUserAsync(User user)
        {
            var savedUser = _dataContext.Users.Add(user).Entity;
            await _dataContext.SaveChangesAsync();
            return savedUser;
        }

        public async Task<User> DeleteUserAsync(int Id)
        {
            var user = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == Id) ?? throw new Exception("user not found");
            _dataContext.Users.Remove(user);
            _dataContext.SaveChanges();
            return user;
        }

        public async Task<String> GetUserAsync(int Id)
        {
            var user = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == Id) ?? throw new Exception("user not found");
            String result = "Name: " + user.Name + "/n Email:" + user.Email;
            return result;
        }

        public List<User> List()
        {
            return _dataContext.Users.ToList();
        }

        public async Task<User> UpdateUserAsync(User user)
        {
            var dbUser = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == user.Id) ?? throw new Exception("user not found");
            _dataContext.Users.Update(user);
            _dataContext.SaveChanges();
            return dbUser;
        }

        Task<User> IUserService.GetUserAsync(int Id)
        {
            var user = _dataContext.Users.FirstOrDefaultAsync(x => x.Id == Id) ?? throw new Exception("user not found");

            return user;
        }
    }
}
