using System.Collections.Generic;
using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class ExcelBL : Singleton<ExcelBL>, IExcelBL
    {
        public List<Excel> GetExcel()
        {
            return ExcelRepository.GetInstance().GetExcel();
        }
    }
}