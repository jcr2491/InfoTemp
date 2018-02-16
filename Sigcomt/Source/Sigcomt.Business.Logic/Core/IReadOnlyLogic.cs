using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.Business.Logic.Core
{
    public interface IReadOnlyLogic<T, Q> where T : class
    {
        IList<T> GetAll(string whereFilters);
        IList<T> GetAllPaging(PaginationParameter<Q> paginationParameters);
        T GetById(T entity);
    }
}
