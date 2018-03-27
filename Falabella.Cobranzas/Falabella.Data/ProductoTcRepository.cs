using System.Collections.Generic;
using System.Data;
using Core.Singleton;
using Falabella.CrossCutting;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class ProductoTcRepository : Singleton<ProductoTcRepository>, IProductoTcRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<ProductoTc> GetProductos()
        {
            var list = new List<ProductoTc>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductosTc"))
            {
                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductoTc>());
                    }
                }
            }

            return list;
        }

        public void Add(int codigo)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.AddProductoTc"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Codigo", DbType.Int32, codigo);

                _database.ExecuteNonQuery(comando);
            }
        }

        public void Delete(int id)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.DeleteProductoTc"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Id", DbType.Int32, id);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion
    }
}