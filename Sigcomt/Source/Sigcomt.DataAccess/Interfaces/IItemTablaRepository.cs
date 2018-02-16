using System.Collections.Generic;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IItemTablaRepository<T,Q> where T : class
    {
        IList<T> GetAllByTablaId(Q tablaId);
    }
}
