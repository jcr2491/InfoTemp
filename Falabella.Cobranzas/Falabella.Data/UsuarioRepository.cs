using System.Data;
using Core.Singleton;
using Falabella.Data.Core;
using Falabella.Data.Interfaces;
using Falabella.Entity;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Falabella.Data
{
    public class UsuarioRepository : Singleton<UsuarioRepository>, IUsuarioRepository
    {
        #region Attributos

        private readonly Database _database = new DatabaseProviderFactory().Create(Connection.ConnectionStrinName);

        #endregion

        #region Métodos Públicos

        public Usuario GetByUsername(string username)
        {
            Usuario usuario = null;

            using (var comando = _database.GetStoredProcCommand($"{Connection.EsquemaName}.GetUsuarioByUsername"))
            {
                _database.AddInParameter(comando, "@Username", DbType.String, username);

                using (var lector = _database.ExecuteReader(comando))
                {
                    if (lector.Read())
                    {
                        usuario = new Usuario
                        {
                            Id = lector.GetInt32(lector.GetOrdinal("Id")),
                            Nombres = lector.GetString(lector.GetOrdinal("Nombres")),
                            Apellidos = lector.GetString(lector.GetOrdinal("Apellidos")),
                            Username = lector.GetString(lector.GetOrdinal("Username"))
                        };
                    }
                }
            }

            return usuario;
        }

        #endregion
    }
}