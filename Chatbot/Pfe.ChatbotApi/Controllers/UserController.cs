using Microsoft.AspNetCore.Mvc;
using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Services.Interfaces;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Pfe.ChatbotApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase

    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }


        // GET: api/<UserController>
        [HttpGet("getUserlist")]
        public IEnumerable<User> Get()
        {
            return _userService.List();
        }

        // GET api/<UserController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<UserController>
        [HttpPost("adduser")]
        public async Task<IActionResult> AddUserAsync(User user)
        {
            if (user == null)
            {
                return BadRequest();
            }

            try
            {
                var response = await _userService.AddUserAsync(user);

                return Ok(response);
            }
            catch
            {
                throw;
            }
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUserAsync(User user)
        {
            if (user == null)
            {
                return BadRequest();
            }

            try
            {
                var result = await _userService.UpdateUserAsync(user);
                return Ok(result);
            }
            catch
            {
                throw;
            }
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public async Task<User> DeleteUserAsync(int Id)
        {
            try
            {
                var response = await _userService.DeleteUserAsync(Id);
                return response;
            }
            catch
            {
                throw;
            }
        }
    }
}
