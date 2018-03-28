using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class UsuarioBL : Singleton<UsuarioBL>, IUsuarioBL
    {
        public Usuario GetByUsername(string username)
        {
            return UsuarioRepository.GetInstance().GetByUsername(username);
        }
    }
}