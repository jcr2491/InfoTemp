using Sigcomt.Business.Logic.Core;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IUsuarioBL<T, Q> : ILogic<T, Q> where T : class
    {
        bool Exists(T entity);
        T GetByUsername(string username);
    }
}
