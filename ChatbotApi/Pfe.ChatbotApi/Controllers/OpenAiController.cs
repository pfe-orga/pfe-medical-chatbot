using Microsoft.AspNetCore.Mvc;
using OpenAI.Net.Models.Requests;
using OpenAI_API;
using OpenAI_API.Completions;

namespace Pfe.ChatbotApi.Controllers
{
    public class OpenAiController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("/getresults")]
        public IActionResult GetResult([FromBody] string prompt)
        {
            string apiKey = "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";
            string answer = string.Empty;
            var openai = new OpenAIAPI(apiKey);
            CompletionRequest completion = new CompletionRequest();
            completion.Prompt = prompt;
            completion.Model = OpenAI_API.Models.Model.DavinciText;
            completion.MaxTokens = 100;
            var result = openai.Completions.CreateCompletionAsync(completion).Result;
            if (result != null)
            {
                foreach (var item in result.Completions)
                {
                    answer = item.Text;
                }
                return Ok(answer);
            }
            else
            {
                return BadRequest("Not Found");
            }
        }
    }
}
