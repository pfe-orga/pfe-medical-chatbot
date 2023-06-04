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

using System.Text.RegularExpressions;
using System.Text.Json;
using System.Data;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json;
using static System.Net.Mime.MediaTypeNames;


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



        [AllowAnonymous]
        [HttpPost("Login")]
        public async Task<IActionResult> PostAsync([FromBody] Login login)
        {
            string passwordHash = BCrypt.Net.BCrypt.HashPassword(login.Password);



            var user = await _context.Users.FirstOrDefaultAsync(x => x.Email == login.Email);
            if (login.Provider == "Facebook" || login.Provider == "Google")
            {
                if (login.Provider == "Google")
                {
                    GoogleJsonWebSignature.Payload payload;
                    try
                    {
                        var settings = new GoogleJsonWebSignature.ValidationSettings
                        {
                            Audience = new[] { _configuration["Google:ClientId"] }
                        };
                        string idToken = string.Empty;
                        payload = await GoogleJsonWebSignature.ValidateAsync(idToken, settings);
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
                string password2
                = BCrypt.Net.BCrypt.HashPassword(login.Password);
                user.Password = password2;
                user.Email = login.Email;
                _context.Users.Add(user);
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
        [AllowAnonymous]
        [HttpGet("Profile")]
        public IActionResult GetUserProfile()
        {
            if (_identityService.ConnectedUser == null)
            {
                return BadRequest("User not authenticated");
            }



            var userProfile = new
            {
                UserName = _identityService.ConnectedUser.UserName,
                Email = _identityService.ConnectedUser.Email
            };



            return Ok(userProfile);
        }



        [AllowAnonymous]
        [HttpPost("Register")]
        public ActionResult<User> Register(UserRequest request)
        {
            if (request.Role.Equals(Role.Admin) && _identityService.ConnectedUser?.Role.Equals(Role.Admin) == false)
            {
                throw new UnauthorizedAccessException();
            }
            string password = BCrypt.Net.BCrypt.HashPassword(request.Password);
            var user = new User
            {
                Name = request.Name,
                Password = password,
                Email = request.Email,
                Role = Role.AllRoles().First(x => x.Equals(request.Role))
            };
            _context.Users.Add(user);
            _context.SaveChanges();
            return Ok(user);
        }



        [Authorize]
        [HttpDelete("Delete/{id}")]
        public async Task<User> DeleteUserAsync(int id)
        {
            if (!_identityService.IsAdmin())
            {
               throw new UnauthorizedAccessException();
            }
            var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == id) ?? throw new Exception("user not found");
            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return user;
        }



        [Authorize]
        [HttpGet("getuser")]
        Task<User> GetUserAsync(String name)
        {
            
            return _context.Users.FirstOrDefaultAsync(x => x.Name == name) ?? throw new Exception("user not found");
        }


        [Authorize]
        [HttpGet("me")]
        public ActionResult Me()
        {
            return Ok(_identityService.ConnectedUser);
        }


        
        [Authorize]
        [HttpGet("List")]
        public List<User> List()
        {
            if (!_identityService.IsAdmin())
            {
               throw new UnauthorizedAccessException();
            }
            return _context.Users.ToList();
            //.ConvertAll(x =>
            //{
               // var user = x;
               // user.Password = string.Empty;
               // return user;
            //});
            
        }
        [Authorize]
        [HttpPut("Update")]
        public async Task<User> UpdateUserAsync(UpdateUser user)
        {
            if (!_identityService.IsAdmin())
            {
                throw new UnauthorizedAccessException();
            }
            var dbUser = await _context.Users.FirstOrDefaultAsync(x => x.Id == user.Id) ?? throw new Exception("user not found");
            dbUser.Email = user.Email;
            dbUser.Name = user.Name;
            await _context.SaveChangesAsync();
            return dbUser;
        }
        [AllowAnonymous]
        [HttpGet("chatbot/{text}")]
        public async Task<PythonResponse> GetChatbotResponseAsync(string text)
        {
            using var client = new HttpClient();
            client.BaseAddress = new Uri("https://2f49-197-240-45-82.ngrok-free.app");
            var request = new PythonRequest
            {
                input_text = text,
            };
            var data = new System.Net.Http.StringContent(JsonSerializer.Serialize(request), Encoding.UTF8, "application/json");
            var result = await client.PostAsync("/api/chatbot", data);
            var content = await result.Content.ReadAsStringAsync();
            Console.Write(content);
            return JsonSerializer.Deserialize<PythonResponse>(content);

        }
        [AllowAnonymous]
        [HttpPost("medicineinfo")]
        public async Task<Resp> GetMedicineInfoAsync(IFormFile file)
        {
            using var client = new HttpClient();
            client.BaseAddress = new Uri("https://2f49-197-240-45-82.ngrok-free.app");

            var requestContent = new MultipartFormDataContent();
            using var stream = file.OpenReadStream();
            using var memoryStream = new MemoryStream();
            await stream.CopyToAsync(memoryStream);
            byte[] fileBytes = memoryStream.ToArray();
            string fileBase64 = "data:image/png;base64,".Replace("png", file.FileName.Split(".")[1]) + Convert.ToBase64String(fileBytes);       
            Console.WriteLine("file:", fileBase64);
            var request = new Request
            {
                input = fileBase64,
            };

            var data = new System.Net.Http.StringContent(JsonSerializer.Serialize(request), Encoding.UTF8, "application/json");
            var result = await client.PostAsync("/api/medbot", data);
            return JsonSerializer.Deserialize<Resp>(await result.Content.ReadAsStringAsync());

        }
        [AllowAnonymous]
        [HttpPost("medicineinfotext")]
        public async Task<Resp> GetMedicineResponse(string text)
        {
            using var client = new HttpClient();
            client.BaseAddress = new Uri("http://localhost:5000");
            var request = new Request
            {
                input = text,
            };
            var data = new System.Net.Http.StringContent(JsonSerializer.Serialize(request), Encoding.UTF8, "application/json");
            var result = await client.PostAsync("/api/medbot", data);
            return JsonSerializer.Deserialize<Resp>(await result.Content.ReadAsStringAsync());

        }



        [AllowAnonymous]
        [HttpGet("showdoctor")]
        public async Task<List<string>> ShowDoctors(string place)
        {
            var GeoLocs = await _context.GeoLocs
                .Where(x => x.place.ToLower().Contains(place.ToLower()))
                .Select(x => x.names).Distinct()
                .ToListAsync();

            if (GeoLocs.Count == 0)
            {
                throw new Exception("No doctors found in the specified place.");
            }

            return GeoLocs;
        }
        [AllowAnonymous]
        [HttpGet("DoctorsList")]
        public List<GeoLocation> DoctorsList()
        { 
            return _context.GeoLocs.ToList();
        }

    }

    public class PythonRequest
    {
        public string input_text { get; set; }
    }

    public class PythonResponse
    {
        //public List<string> history { get; set; }
        public PythonResponseAt response { get; set; }
        //public List<string> hist { get; set; }


    }

    public class PythonResponseAt
    {
        //public List<string> history { get; set; }
        public string response { get; set; }
        public List<string> record { get; set; }
        public List<string> hist { get; set; }


    }

    public class UpdateUser
    {
        [Required]
        public int Id { get; set; }
        [Required]
        public String Name { get; set; }
        [Required]
        public String Email { get; set; }
    }
   
    public class Resp
    {
        public string medicine_name { get; set; }
        public string price { get; set; }
        public string date { get; set; }
        public string error { get; set; }
    }
    public class Request
    {
        public string input { get; set;}
    }


}
