using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System.Collections.Generic;
using System.Data;
using Core.Singleton;

namespace Sigcomt.DataAccess
{
    public class ItemTablaRepository : Singleton<ItemTablaRepository>, IItemTablaRepository<ItemTabla,int>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSql);

        #endregion

        #region Métodos Públicos

        public IList<ItemTabla> GetAllByTablaId(int tablaId)
        {
            List<ItemTabla> itemTablaList = new List<ItemTabla>();
            using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "ItemTablaGetAllByTablaId")))
            {
                _database.AddInParameter(comando, "@TablaId", DbType.Int32, tablaId);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        itemTablaList.Add(new ItemTabla
                        {                            
                            Id = lector.IsDBNull(lector.GetOrdinal("Id")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Id")),
                            Nombre = lector.IsDBNull(lector.GetOrdinal("Nombre")) ? default(string) : lector.GetString(lector.GetOrdinal("Nombre")),
                            Valor = lector.IsDBNull(lector.GetOrdinal("Valor")) ? default(string) : lector.GetString(lector.GetOrdinal("Valor")),
                            TablaId = lector.IsDBNull(lector.GetOrdinal("TablaId")) ? default(int) : lector.GetInt32(lector.GetOrdinal("TablaId")),
                            Estado = lector.IsDBNull(lector.GetOrdinal("Estado")) ? default(int) : lector.GetInt32(lector.GetOrdinal("Estado"))
                        });
                    }
                }
            }

            return itemTablaList;
        } 

        #endregion
    }
}
