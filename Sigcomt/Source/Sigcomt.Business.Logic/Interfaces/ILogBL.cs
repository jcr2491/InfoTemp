namespace Sigcomt.Business.Logic.Interfaces
{
    public interface ILogBL<T,Q> where T : class
    {
        Q Add(T entity);
    }
}
