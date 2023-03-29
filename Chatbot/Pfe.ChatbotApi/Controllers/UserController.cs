using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Org.BouncyCastle.Crypto.Generators;
using Pfe.ChatbotApi.Core;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Pfe.ChatbotApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController] 
    public class UserController : ControllerBase
    {
        public static User user =new User();
        public readonly IConfiguration _configuration;
        public UserController(IConfiguration configuration)
        {
           _configuration = configuration;
        }

        [HttpPost("register")]
        public ActionResult<User>Register(Userrequest request)
        {
           string password 
                = BCrypt.Net.BCrypt.HashPassword(request.Password); 
            user.Name=request.Name; 
            user.Password=password;
            user.Email=request.Email;
            return Ok(user);
        }
        [HttpPost("login")]
        public ActionResult<User> login(Userrequest request)
        {
            if(user.Email!=request.Email)
            {
                return BadRequest("user not found.");
            }
            if (!BCrypt.Net.BCrypt.Verify(request.Password, user.Password))
            {
                return BadRequest("wrong password.");
            }
            return Ok(user);
        }
        public string CreateToken(User user)
        {
            List<Claim> claims = new List<Claim>() {
                new Claim(ClaimTypes.Name, user.Email)
        };
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                _configuration.GetSection("AppSettings:token").Value));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);
            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials:creds

                ) ; 
            var jwt = new JwtSecurityTokenHandler().WriteToken(token) ;
            return jwt;
        }
    }
}
