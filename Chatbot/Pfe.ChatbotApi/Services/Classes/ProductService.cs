using Pfe.ChatbotApi.Core;
using Pfe.ChatbotApi.Services.Interfaces;
using System.Collections.Generic;

namespace Pfe.ChatbotApi.Services.Classes
{
    public class ProductService : IProductService
    {
        private readonly DataContext _dataContext;
        public ProductService(DataContext dataContext)
        {
            _dataContext = dataContext;
        }
        public void Add(Product product)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public List<Product> List()
        {
            return _dataContext.Products.ToList();
        }

        public void Update(Product product)
        {
            throw new NotImplementedException();
        }
    }
}
