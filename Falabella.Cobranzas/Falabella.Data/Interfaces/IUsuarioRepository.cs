using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IUsuarioRepository
    {
        Usuario GetByUsername(string username);
    }
}