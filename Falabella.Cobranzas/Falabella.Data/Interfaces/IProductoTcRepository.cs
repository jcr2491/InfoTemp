using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IProductoTcRepository
    {
        List<ProductoTc> GetProductos();
        void Add(int codigo);
        void Delete(int id);
    }
}