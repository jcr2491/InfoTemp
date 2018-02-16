using Sigcomt.Common;
using System.Collections.Generic;
using System.Data;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface ICargoBL<T, Q> where T : class
    {
        IList<T> GetAll(PaginationParameter<Q> paginationParameter);
        IList<T> GetById(Q id);
    }
}
