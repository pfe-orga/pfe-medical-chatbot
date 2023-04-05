using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Facebook;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Dto;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Pfe.ChatbotApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SecurityController : ControllerBase

    {   public static User user = new User();
        private readonly DataContext _context;
        private readonly IConfiguration _configuration;
        public SecurityController(IConfiguration configuration, DataContext context)
        {
            _context = context;

            _configuration = configuration;
        }

        //// POST api/<SecurityController>
        [AllowAnonymous]
        [HttpPost("token")]
        public async Task<IActionResult> Post([FromBody] Login login)
        {
            if (login.UserName == "admin" && login.Password == "admin")
            {
                var claims = new List<Claim>
        {
            new Claim("Id", Guid.NewGuid().ToString()),
            new Claim(JwtRegisteredClaimNames.Sub, login.UserName),
            new Claim(JwtRegisteredClaimNames.Email, login.UserName),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

                // Add additional claims as needed

                var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(claimsIdentity));

                // Redirect to Facebook login
                if (login.Provider == "Facebook")
                {
                    return Challenge(new AuthenticationProperties { RedirectUri = "/" }, FacebookDefaults.AuthenticationScheme);
                }

                var token = GenerateToken(claims);
                return Ok(token);
            }
            return Unauthorized("Invalid user or password");
        }

        [HttpPost("register")]
        public ActionResult<User> Register(UserRequest request)
        {
            string password
                 = BCrypt.Net.BCrypt.HashPassword(request.Password);
            user.Name = request.Name;
            user.Password = password;
            user.Email = request.Email;
            _context.Users.Add(user);


            return Ok(user);
        }
        [Authorize]
        // PUT api/<SecurityController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        [Authorize]
        // DELETE api/<SecurityController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
