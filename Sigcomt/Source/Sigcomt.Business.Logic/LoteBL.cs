using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class LoteBL : Singleton<LoteBL>, ILoteBL<Lote>
    {
        public int AddWithMonitoreo(Lote entity, string ruta)
        {
            return LoteRepository.GetInstance().AddWithMonitoreo(entity, ruta);
        }

        public bool Exists(Lote entity)
        {
            return LoteRepository.GetInstance().Exists(entity);
        }
    }
}