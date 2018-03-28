using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Core.Singleton;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class ParametroRepository : Singleton<ParametroRepository>, IParametroRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(ConectionStringRepository.ConnectionStringNameSql);

        #endregion

        #region Métodos Públicos

        public Parametros GetParametros(string CodigoParametros)
        {
            var parametros = new Parametros();

            using (var comando = _database.GetStoredProcCommand($"{ConectionStringRepository.EsquemaName}.GetParametros"))
            {
                _database.AddInParameter(comando, "@CodigoParametro", DbType.String, CodigoParametros);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        parametros.Id = lector.GetInt32(lector.GetOrdinal("Id"));
                        parametros.Codigo = lector.GetString(lector.GetOrdinal("Codigo"));
                        parametros.TipoComision = lector.GetInt32(lector.GetOrdinal("TipoComision"));
                        parametros.FechaVigencia = lector.GetDateTime(lector.GetOrdinal("FechaVigencia"));
                        parametros.Estado = lector.GetBoolean(lector.GetOrdinal("Estado"));
                        parametros.Descripcion = lector.GetString(lector.GetOrdinal("Descripcion"));
                        parametros.ValorNumerico = lector.GetInt32(lector.GetOrdinal("ValorNumerico"));
                        parametros.ValorTexto = lector.GetString(lector.GetOrdinal("ValorTexto"));
                        parametros.ValorDecimal = lector.GetDouble(lector.GetOrdinal("ValorDecimal"));
                        parametros.ValorBoleano = lector.GetBoolean(lector.GetOrdinal("ValorBoleano"));
                        parametros.ValorFecha = lector.GetDateTime(lector.GetOrdinal("ValorFecha"));                       

                    }
                }
            }
            return parametros;
        }

        #endregion
    }
}
