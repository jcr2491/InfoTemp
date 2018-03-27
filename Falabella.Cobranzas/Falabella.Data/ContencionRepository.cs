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
    public class ContencionRepository : Singleton<ContencionRepository>, IContencionRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<ContencionReport> GetContencion(ContencionFilter filter)
        {
            var list = new List<ContencionReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetContencionTramoMora"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ContencionReport>());
                    }
                }
            }

            return list;
        }

        public List<ContencionCierreReport> GetContencionCierre(string fecha)
        {
            var list = new List<ContencionCierreReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ContencionCierreReport>());
                    }
                }
            }

            return list;
        }

        public List<RangoContencionCierre> GetRangoContencionCierre(string fecha)
        {
            var list = new List<RangoContencionCierre>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetRangoContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<RangoContencionCierre>());
                    }
                }
            }

            return list;
        }
        public List<HistoricoContencionCierre> GetHistoricoContencionCierre(string fecha)
        {
            var list = new List<HistoricoContencionCierre>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetHistoricoContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<HistoricoContencionCierre>());
                    }
                }
            }

            return list;
        }

        public void AddHistoricoContencionCierre(string fecha)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.AddHistoricoContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                _database.ExecuteNonQuery(comando);
            }
        }

        public bool ExisteHistoricoContencionCierre(string fecha)
        {
            bool existe = false;

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.ExisteHistoricoContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        existe = lector.GetInt32(0) == 1;
                    }
                }
            }

            return existe;
        }

        public void DeleteRangos(string fecha)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.DeleteRangoContencionCierre"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, fecha);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion
    }
}