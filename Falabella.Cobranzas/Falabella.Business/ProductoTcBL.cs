using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class ProductoTcBL : Singleton<ProductoTcBL>, IProductoTcBL
    {
        public List<ProductoTc> GetProductos()
        {
            return ProductoTcRepository.GetInstance().GetProductos();
        }

        public void Add(int codigo)
        {
            ProductoTcRepository.GetInstance().Add(codigo);
        }

        public void Delete(int id)
        {
            ProductoTcRepository.GetInstance().Delete(id);
        }
    }
}