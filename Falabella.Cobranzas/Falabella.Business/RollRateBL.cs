using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.CrossCutting.Filters;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class RollRateBL : Singleton<RollRateBL>, IRollRateBL
    {
        public List<RollRatesReport> GetRollRates(ContencionFilter filter)
        {
            return RollRateRepository.GetInstance().GetRollRates(filter);
        }

        public List<RollRatesDiarioReport> GetRollRatesDiario(string fecha)
        {
            return RollRateRepository.GetInstance().GetRollRatesDiario(fecha);
        }
    }
}