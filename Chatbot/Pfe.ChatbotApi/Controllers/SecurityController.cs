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
        private readonly IConfiguration _configuration;
        public SecurityController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        //// POST api/<SecurityController>
        [AllowAnonymous]
        [HttpPost("token")]
        public ActionResult Post([FromBody] Login login)
        {
            if (login.UserName == "admin" && login.Password == "admin")
            {
                var issuer = _configuration["Jwt:Issuer"];
                var audience = _configuration["Jwt:Audience"];
                var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                new Claim("Id", Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Sub, login.UserName),
                new Claim(JwtRegisteredClaimNames.Email, login.UserName),
                new Claim(JwtRegisteredClaimNames.Jti,
                Guid.NewGuid().ToString())
             }),
                    Expires = DateTime.UtcNow.AddMinutes(2),
                    Issuer = issuer,
                    Audience = audience,
                    SigningCredentials = new SigningCredentials
                    (new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha512Signature)
                };
                var tokenHandler = new JwtSecurityTokenHandler();
                var token = tokenHandler.CreateToken(tokenDescriptor);
                var jwtToken = tokenHandler.WriteToken(token);
                var stringToken = tokenHandler.WriteToken(token);
                return Ok(stringToken);
            }
            return Unauthorized("invalid user or pwd");
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
