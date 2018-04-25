using System;

namespace Anexo17.Clases
{
    public class ParametroCobertura
    {
        public string Nombre { get; set; }
        public decimal TipoCambio { get; set; }
        public string TipoCta { get; set; }
        public DateTime FechaIni { get; set; }
        public DateTime FechaFin { get; set; }
        public string Condicion { get; set; }
        public decimal MontoFsd { get; set; }
    }
}