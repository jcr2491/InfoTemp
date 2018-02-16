
namespace Sigcomt.ActiveDirectory.Interfaces
{
    public interface IUsuarioAD
    {
        bool AutenticarEnDominio(string username, string password);
    }
}
