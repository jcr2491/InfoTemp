using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Core.Singleton;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class UsuarioBL : Singleton<UsuarioBL>, IUsuarioBL
    {
        public Usuario GetUsuario(string username, string clave)
        {
            return UsuarioRepository.GetInstance().GetUsuario(username, clave);
        }
    }
}