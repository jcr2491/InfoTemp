using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IProductoTcBL
    {
        List<ProductoTc> GetProductos();
        void Delete(int id);
        void Add(int codigo);
    }
}