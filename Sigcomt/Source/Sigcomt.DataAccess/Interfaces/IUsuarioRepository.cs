using Sigcomt.Business.Entity;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IUsuarioRepository
    {
        Usuario GetUsuario(string username, string clave);
    }
}