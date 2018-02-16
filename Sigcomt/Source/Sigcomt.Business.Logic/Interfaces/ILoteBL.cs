namespace Sigcomt.Business.Logic.Interfaces
{
    public interface ILoteBL<T>
        where T : class
    {
        int AddWithMonitoreo(T entity, string ruta);
        bool Exists(T entity);
    }
}
