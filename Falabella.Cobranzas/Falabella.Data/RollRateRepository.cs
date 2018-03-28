using System.Collections.Generic;
using System.Data;
using Core.Singleton;
using Falabella.CrossCutting;
using Falabella.CrossCutting.Filters;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class RollRateRepository : Singleton<RollRateRepository>, IRollRateRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<RollRatesReport> GetRollRates(ContencionFilter filter)
        {
            var list = new List<RollRatesReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetRollRates"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaIni", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<RollRatesReport>());
                    }
                }
            }

            return list;
        }

        public List<RollRatesDiarioReport> GetRollRatesDiario(string fecha)
        {
            var list = new List<RollRatesDiarioReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetRollRatesDiario"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<RollRatesDiarioReport>());
                    }
                }
            }

            return list;
        }

        #endregion
    }
}