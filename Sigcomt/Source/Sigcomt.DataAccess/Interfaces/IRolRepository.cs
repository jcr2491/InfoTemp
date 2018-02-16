using System.Collections.Generic;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IRolRepository<T> where T : class
    {
        IList<T> GetAllActives();
    }
}
