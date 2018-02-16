using System.Collections.Generic;
using Sigcomt.Business.Entity;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IExcelRepository
    {
        List<Excel> GetExcel();
    }
}