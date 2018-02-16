using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface ICargoRepository<T, Q> where T : class
    {

        IList<T> GetAll(PaginationParameter<Q> paginationParameter);
        IList<T> GetById(Q Id);
    }
}
