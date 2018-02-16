using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class LogBL : Singleton<LogBL>, ILogBL<Log,long>
    {
        public long Add(Log entity)
        {
            return LogRepository.GetInstance().Add(entity);
        }
    }
}
