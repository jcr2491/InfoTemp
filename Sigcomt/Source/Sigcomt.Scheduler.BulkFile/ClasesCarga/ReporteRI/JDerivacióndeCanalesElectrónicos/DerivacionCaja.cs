using System.Collections.Generic;
using Sigcomt.Scheduler.BulkFile.Core;

namespace Sigcomt.Scheduler.BulkFile.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos
{
    public class DerivacionCaja
    {
        public string TipoArchivo { get; set; }
        public Dictionary<string, PropiedadColumna> PropiedadCol { get; set; }
    }
}