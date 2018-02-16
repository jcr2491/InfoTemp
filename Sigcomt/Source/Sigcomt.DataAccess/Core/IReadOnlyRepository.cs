using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.DataAccess.Core
{
    public interface IReadOnlyRepository<T, Q> where T : class
    {
        IList<T> GetAll(string whereFilters);
        IList<T> GetAllPaging(PaginationParameter<Q> paginationParameters);
        T GetById(T entity);
    }
}
