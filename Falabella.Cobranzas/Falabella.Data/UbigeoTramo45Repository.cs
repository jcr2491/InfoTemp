using System.Collections.Generic;
using Core.Singleton;
using Falabella.CrossCutting;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class UbigeoTramo45Repository : Singleton<UbigeoTramo45Repository>, IUbigeoTramo45Repository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public List<Zona> GetZonas()
        {
            var list = new List<Zona>();

            using (var comando = _database.GetStoredProcCommand(string.Format("{0}.{1}", Connection.EsquemaName, "GetZonas")))
            {

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<Zona>());
                    }
                }
            }

            return list;
        }

        public List<TipoZona> GetTipoZonas()
        {
            var list = new List<TipoZona>();

            using (var comando = _database.GetStoredProcCommand(string.Format("{0}.{1}", Connection.EsquemaName, "GetTipoZonas")))
            {

                using (var lector = _database.ExecuteReader(comando))
                {
                    while (lector.Read())
                    {
                        list.Add(lector.ConvertedEntity<TipoZona>());
                    }
                }
            }

            return list;
        }

        #endregion
    }
}