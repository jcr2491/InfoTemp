using System.Collections.Generic;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IRollRateRepository
    {
        List<RollRatesReport> GetRollRates(ContencionFilter filter);
        List<RollRatesDiarioReport> GetRollRatesDiario(string fecha);
    }
}