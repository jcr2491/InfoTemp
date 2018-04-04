using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Core.Singleton;
using Dapper;
using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;

namespace Sigcomt.DataAccess
{
    public class ConfiguracionRepository : Singleton<ConfiguracionRepository>, IConfiguracionRepository
    {
        #region Attributos

        private readonly IDbConnection _database = new SqlConnection(ConectionStringRepository.ConnectionStringSql);

        #endregion

        #region Métodos Públicos

        public Configuracion GetConfiguracion(string tipoConfiguracion)
        {
            var conf = _database.Query<Configuracion>($"{ConectionStringRepository.EsquemaName}.GetConfiguracion",
                new { TipoConfiguracion = tipoConfiguracion }, commandType: CommandType.StoredProcedure).SingleOrDefault();

            return conf;
        }

        #endregion
    }
}