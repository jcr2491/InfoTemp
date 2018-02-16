using System.Collections.Generic;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IRolBL<T> where T : class
    {
        IList<T> GetAllActives();
    }
}
