using System.Data;
using Core.Singleton;
using Falabella.CrossCutting;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class MetaRefinanciadoRepository : Singleton<MetaRefinanciadoRepository>, IMetaRefinanciadoRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public MetaRefinanciado GetMetaRefinanciadoPorMes(string fechaMeta)
        {
            MetaRefinanciado meta = null;

            using (var comando = _database.GetStoredProcCommand(string.Format("{0}.{1}", Connection.EsquemaName, "GetMetaRefinanciadoPorMes")))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaMeta", DbType.DateTime, fechaMeta);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        meta = lector.ConvertedEntity<MetaRefinanciado>();
                    }
                }
            }

            return meta;
        }

        public void UpdateFactorCrecimiento(string fechaMeta, double factorCrecimiento)
        {
            using (var comando = _database.GetStoredProcCommand(string.Format("{0}.{1}", Connection.EsquemaName, "UpdateFactorCrecimiento")))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaMeta", DbType.DateTime, fechaMeta);
                _database.AddInParameter(comando, "@FactorCrecimiento", DbType.Double, factorCrecimiento);

                _database.ExecuteNonQuery(comando);
            }
        }

        #endregion
    }
}