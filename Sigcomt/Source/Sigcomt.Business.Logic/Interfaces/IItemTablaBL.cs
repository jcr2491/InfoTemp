using System.Collections.Generic;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IItemTablaBL<T,Q> where T : class
    {
        IList<T> GetAllByTablaId(Q tablaId);
    }
}
