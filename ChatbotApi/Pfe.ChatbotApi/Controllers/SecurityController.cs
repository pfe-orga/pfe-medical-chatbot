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
using Google.Apis.Auth;
using Azure.Core;
using Microsoft.AspNetCore.Identity;
using Pfe.ChatbotApi.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Pfe.ChatbotApi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SecurityController : ControllerBase

    {
        private readonly DataContext _context;
        private readonly IConfiguration _configuration;
        private readonly IdentityService _identityService;


        public SecurityController(IConfiguration configuration, DataContext context, IdentityService identityService)
        {
            _context = context;
            _configuration = configuration;
            _identityService = identityService;
        }

        //// POST api/<SecurityControllerpasswordHash
        [AllowAnonymous]
        [HttpPost("token")]
        public async Task<IActionResult> PostAsync([FromBody] Login login)
        {
            var user = await _context.Users.FirstOrDefaultAsync(x => x.Email == login.Email);
            if (login.Provider == "facebook" || login.Provider == "google")
            {
                if (login.Provider == "google")
                {
                    GoogleJsonWebSignature.Payload payload;
                    try
                    {
                        var settings = new GoogleJsonWebSignature.ValidationSettings
                        {
                            Audience = new[] { _configuration["Google:ClientId"] }
                        };
                        //payload = await GoogleJsonWebSignature.ValidateAsync(idToken, settings);
                    }
                    catch (InvalidJwtException)
                    {
                        return BadRequest("Invalid token.");
                    }
                }
                var issuer = _configuration["Jwt:Issuer"];
                var audience = _configuration["Jwt:Audience"];
                var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                        new Claim("Id", Guid.NewGuid().ToString()),
                        new Claim(JwtRegisteredClaimNames.Sub, login.Email),
                        new Claim(JwtRegisteredClaimNames.Email, login.Email),
                        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                    }),
                    Expires = DateTime.UtcNow.AddDays(7),
                    Issuer = issuer,
                    Audience = audience,
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
                        SecurityAlgorithms.HmacSha512Signature)
                };
                var tokenHandler = new JwtSecurityTokenHandler();
                var token = tokenHandler.CreateToken(tokenDescriptor);
                var jwtToken = tokenHandler.WriteToken(token);
                var stringToken = tokenHandler.WriteToken(token);
                string password2 = BCrypt.Net.BCrypt.HashPassword(login.Password);
                
                if(user == null)
                {
                    _context.Users.Add(new Core.User
                    {
                        Email = login.Email,
                        Password = password2
                    });
                }
                else
                {
                    user.Password = password2;
                    user.Email = login.Email;
                }
                _context.SaveChanges();

                return Ok(stringToken);
            }

            else if (user != null && BCrypt.Net.BCrypt.Verify(login.Password, user.Password))
            {
                // Authenticate with username and password and generate JWT token
                var issuer = _configuration["Jwt:Issuer"];
                var audience = _configuration["Jwt:Audience"];
                var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]);
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                        new Claim("Id", Guid.NewGuid().ToString()),
                        new Claim(JwtRegisteredClaimNames.Sub, login.Email),
                        new Claim(JwtRegisteredClaimNames.Email, login.Email),
                        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                    }),
                    Expires = DateTime.UtcNow.AddDays(7),
                    Issuer = issuer,
                    Audience = audience,
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
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
            var existingUser = _context.Users.FirstOrDefault(u => u.Email == request.Email);
            if (existingUser != null)
            {
                return BadRequest("User with same email already exists");
            }
            string password  = BCrypt.Net.BCrypt.HashPassword(request.Password);
            var user = new User
            {
                Name = request.Name,
                Password = password,
                Email = request.Email
            };
            _context.Users.Add(user);
            _context.SaveChanges();


            return Ok(user);
        }

        [Authorize]
        // PUT api/<SecurityController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        [Authorize]
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }

        [Authorize]
        [HttpGet("me")]
        public ActionResult Me()
        {
            return Ok(_identityService.ConnectedUser);
        }
    }
}
