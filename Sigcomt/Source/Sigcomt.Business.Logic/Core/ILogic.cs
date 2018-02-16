using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.Business.Logic.Core
{
    public interface ILogic<T, Q> where T : class
    {
        int Add(T entity);
        int Delete(T entity);
        IList<T> GetAll(string whereFilters);
        IList<T> GetAllPaging(PaginationParameter<Q> paginationParameters);
        T GetById(T entity);
        int Update(T entity);
    }
}
