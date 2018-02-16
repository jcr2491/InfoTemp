using Sigcomt.Common;
using System.Collections.Generic;

namespace Sigcomt.DataAccess.Interfaces
{
    interface IMPonderacionRepository<T, Q> where T : class
    {
        IList<T> GetAll(PaginationParameter<Q> paginationParameter);
        IList<T> GetById(Q Id);
    }
}
