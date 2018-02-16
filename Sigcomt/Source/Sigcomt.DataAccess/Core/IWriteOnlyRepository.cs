namespace Sigcomt.DataAccess.Core
{
    public interface IWriteOnlyRepository<T> where T : class
    {
        int Add(T entity);
        int Delete(T entity);
        int Update(T entity);
    }
}
