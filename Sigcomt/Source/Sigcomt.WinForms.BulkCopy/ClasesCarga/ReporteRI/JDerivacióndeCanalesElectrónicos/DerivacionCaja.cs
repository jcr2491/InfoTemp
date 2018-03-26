using System.Collections.Generic;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.ClasesCarga.ReporteRI.JDerivacióndeCanalesElectrónicos
{
    public class DerivacionCaja
    {
        public string TipoArchivo { get; set; }
        public Dictionary<string, PropiedadColumna> PropiedadCol { get; set; }
    }
}