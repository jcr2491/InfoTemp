namespace Sigcomt.DataAccess.Interfaces
{
    public interface ILoteRepository<T, Q>
        where T : class
    {
        Q AddWithMonitoreo(T entity, string ruta);
        bool Exists(T entity);
    }
}
