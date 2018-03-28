using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System;
using System.Data;
using Core.Singleton;

namespace Sigcomt.DataAccess
{
    public class LogRepository : Singleton<LogRepository>, ILogRepository<Log,long>
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSql);

        #endregion

        #region Métodos Públicos

        public long Add(Log entity)
        {
            long id;

            using (var comando = _database.GetStoredProcCommand(string.Format("{0}{1}", ConectionStringRepository.EsquemaName, "LogInsert")))
            {
                _database.AddInParameter(comando, "@Usuario", DbType.String, entity.Usuario);
                _database.AddInParameter(comando, "@Mensaje", DbType.String, entity.Mensaje);
                _database.AddInParameter(comando, "@Controlador", DbType.String, entity.Controlador);
                _database.AddInParameter(comando, "@Accion", DbType.String, entity.Accion);
                _database.AddInParameter(comando, "@Objeto", DbType.String, entity.Objeto);
                _database.AddInParameter(comando, "@Identificador", DbType.Int64, entity.Identificador);
                _database.AddOutParameter(comando, "@Response", DbType.Int32, 11);

                _database.ExecuteNonQuery(comando);
                id = Convert.ToInt64(_database.GetParameterValue(comando, "@Response"));
            }

            return id;
        }

        #endregion
    }
}
