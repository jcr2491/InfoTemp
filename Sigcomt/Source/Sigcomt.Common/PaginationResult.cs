using System.Collections.Generic;

namespace Sigcomt.Common
{
    public class PaginationResult<T> where T : class
    {
        public int Count { get; set; }

        public IEnumerable<T> Entities { get; set; }
    }
}
