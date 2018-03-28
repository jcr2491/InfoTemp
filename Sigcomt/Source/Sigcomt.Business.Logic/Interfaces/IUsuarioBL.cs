using Sigcomt.Business.Entity;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IUsuarioBL
    {
        Usuario GetUsuario(string username, string clave);
    }
}