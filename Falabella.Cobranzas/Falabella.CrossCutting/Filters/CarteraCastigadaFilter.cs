using System.Collections.Generic;

namespace Falabella.CrossCutting.Filters
{
    public class CarteraCastigadaFilter
    {
        public string FechaIni { get; set; }
        public double FactorCrecimiento { get; set; }
        public List<EstudioMeta> EstudioMetaList { get; set; }
    }
}