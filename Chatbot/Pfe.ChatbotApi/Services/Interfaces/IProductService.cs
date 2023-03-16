using Pfe.ChatbotApi.Core;

namespace Pfe.ChatbotApi.Services.Interfaces
{
    public interface IProductService
    {
        void Add(Product product);
        void Update(Product product);
        void Delete(int id);
        List<Product> List();

    }
}
