using Microsoft.EntityFrameworkCore;
using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Services.Interfaces;
using System.Collections.Generic;

namespace Pfe.ChatbotApi.Services.Classes
{
    public class UserService : IUserService
    {
        private readonly DataContext _dataContext;
        public UserService(DataContext dataContext)
        {
            _dataContext = dataContext;
        }
        public async Task<User> AddUserAsync(User user)
        {
             
            var savedUser = _dataContext.Users.Add(user).Entity;
            _dataContext.SaveChanges();
            return savedUser;
        }



        public async Task<User> DeleteUserAsync(int Id)
        {
            var user = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == Id);
            if(user == null)
            {
                throw new Exception("user not found");

            }
            _dataContext.Users.Remove(user);
            _dataContext.SaveChanges();
            return user;
        }
        

        public List<User> List()
        {
            return _dataContext.Users.ToList();
        }

        public async Task<User> UpdateUserAsync(User user)
        {
            var dbUser = await _dataContext.Users.FirstOrDefaultAsync(x => x.Id == user.Id) ;
            if (dbUser == null)
            {
                throw new Exception("user not found");

            }
            
            _dataContext.Users.Update(user);
            _dataContext.SaveChanges();
            return dbUser;
        }
    }
}
