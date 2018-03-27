﻿using System.Collections.Generic;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IRollRateBL
    {
        List<RollRatesReport> GetRollRates(ContencionFilter filter);
        List<RollRatesDiarioReport> GetRollRatesDiario(string fecha);
    }
}