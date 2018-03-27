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
    public class EstudioRepository : Singleton<EstudioRepository>, IEstudioRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<Estudio> GetEstudios(string fechaMeta)
        {
            var list = new List<Estudio>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetEstudios"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaMeta", DbType.DateTime, fechaMeta);

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<Estudio>());
                    }
                }
            }

            return list;
        }

        public void DeleteEstudioMeta(string fechaMeta)
        {
            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.DeleteMetaEstudio"))
            {
                comando.CommandTimeout = int.MaxValue;
                _database.AddInParameter(comando, "@FechaMeta", DbType.DateTime, fechaMeta);

                _database.ExecuteNonQuery(comando);
            }
        }

        public List<RegionEstudio> GetRegionEstudios()
        {
            var list = new List<RegionEstudio>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetRegionEstudios"))
            {

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<RegionEstudio>());
                    }
                }
            }

            return list;
        }

        public List<TipoEstudio> GetTipoEstudios()
        {
            var list = new List<TipoEstudio>();

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetTipoEstudios"))
            {

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<TipoEstudio>());
                    }
                }
            }

            return list;
        }

        #endregion
    }
}