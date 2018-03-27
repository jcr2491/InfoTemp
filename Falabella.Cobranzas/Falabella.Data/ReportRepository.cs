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
    public class ReportRepository : Singleton<ReportRepository>, IReportRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<CarteraCastigadaReport> GetCarteraCastigada(CarteraCastigadaFilter filter)
        {
            var list = new List<CarteraCastigadaReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetCarteraCastigada"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaFin", DbType.DateTime, filter.FechaIni);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<CarteraCastigadaReport>());
                    }
                }
            }

            return list;
        }

        public List<RecuperoCastigoReport> GetRecuperoCastigo(CarteraCastigadaFilter filter)
        {
            var list = new List<RecuperoCastigoReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetRecuperoCastigo"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.FechaIni);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<RecuperoCastigoReport>());
                    }
                }
            }

            return list;
        }

        public List<CarteraRefinanciadaReport> GetCarteraRefinanciada(CarteraRefinanciadaFilter filter)
        {
            var list = new List<CarteraRefinanciadaReport>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetCarteraRefinanciada"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaFin", DbType.DateTime, filter.FechaFin);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<CarteraRefinanciadaReport>());
                    }
                }
            }

            return list;
        }

        public List<ProductividadTramo1Report> GetProductividadTramo1(ProductividadFilter filter)
        {
            var list = new List<ProductividadTramo1Report>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductividadTramo1"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductividadTramo1Report>());
                    }
                }
            }

            return list;
        }

        public List<ProductividadTramo2Report> GetProductividadTramo2(ProductividadFilter filter)
        {
            var list = new List<ProductividadTramo2Report>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductividadTramo2"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductividadTramo2Report>());
                    }
                }
            }

            return list;
        }

        public List<ProductividadTramo3Report> GetProductividadTramo3(ProductividadFilter filter)
        {
            var list = new List<ProductividadTramo3Report>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductividadTramo3"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductividadTramo3Report>());
                    }
                }
            }

            return list;
        }

        public List<ProductividadTramo4Report> GetProductividadTramo4(ProductividadFilter filter)
        {
            var list = new List<ProductividadTramo4Report>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductividadTramo4"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductividadTramo4Report>());
                    }
                }
            }

            return list;
        }

        public List<ProductividadTramo5Report> GetProductividadTramo5(ProductividadFilter filter)
        {
            var list = new List<ProductividadTramo5Report>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetProductividadTramo5"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@Fecha", DbType.DateTime, filter.Fecha);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<ProductividadTramo5Report>());
                    }
                }
            }

            return list;
        }

        #endregion
    }
}