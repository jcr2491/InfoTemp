using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IUsuarioBL
    {
        Usuario GetByUsername(string username);
    }
}