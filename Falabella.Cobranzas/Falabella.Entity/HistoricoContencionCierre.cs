using System;

namespace Falabella.Entity
{
    public class HistoricoContencionCierre
    {
        public DateTime Fecha { get; set; }
        public int PaisId { get; set; }
        public int Rango { get; set; }
        public int DiaMoraMin { get; set; }
        public int DiaMoraMax { get; set; }
        public double CapitalTotal { get; set; }
        public double CapitalContenido { get; set; }
        public double CapitalPagoTotal { get; set; }
        public double CapitalRenegociada { get; set; }
        public double CapitalPagoCuotaAtrasada { get; set; }
    }
}