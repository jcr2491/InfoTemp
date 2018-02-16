using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.DataAccess.Core
{
    public interface IRepository<T, Q> where T : class
    {
        int Add(T entity);
        int Delete(T entity);
        IList<T> GetAll(string whereFilters);
        IList<T> GetAllPaging(PaginationParameter<Q> paginationParameters);
        T GetByIdGetById(T entity);
        int Update(T entity);
    }
}