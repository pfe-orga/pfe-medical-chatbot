using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pfe.ChatbotApi.Services.Classes;

namespace Pfe.ChatbotApi.Controllers { 

[Route("[controller]")]
    [Authorize]
    public class UsersController : Controller
    {   
        [HttpPost]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Create a new User object to store in the database
                var user = new User
                {
                    Name = model.Name,
                    Email = model.Email
                    // You may need to hash the password before storing it in the database
                };

                // Save the new User object to the database using the DbContext
                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                // Redirect the user to a success page
                return RedirectToAction("RegistrationComplete");
            }

            // If the model state is invalid, redisplay the registration form with validation errors
            return View(model);
        }


        // If the model state is invalid, redisplay the registration form with validation errors

        private readonly ApplicationDbContext _context;

        public UsersController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.Users.ToListAsync();
        }

        // ...
    }
}