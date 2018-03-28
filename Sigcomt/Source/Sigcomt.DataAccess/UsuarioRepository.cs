using Sigcomt.Business.Entity;
using Sigcomt.DataAccess.Core;
using Sigcomt.DataAccess.Interfaces;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Core.Singleton;
using Dapper;

namespace Sigcomt.DataAccess
{
    public class UsuarioRepository : Singleton<UsuarioRepository>, IUsuarioRepository
    {
        #region Attributos
        
        private readonly IDbConnection _database = new SqlConnection(ConectionStringRepository.ConnectionStringSql);

        #endregion

        #region Métodos Públicos

        public Usuario GetUsuario(string username)
        {
            var user = _database.Query<Usuario>($"{ConectionStringRepository.EsquemaName}.GetUsuario",
                new {UserName = username}, commandType: CommandType.StoredProcedure).SingleOrDefault();

            return user;
        }

        #endregion
    }
}
