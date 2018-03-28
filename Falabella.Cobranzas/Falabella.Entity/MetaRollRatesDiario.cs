using System;

namespace Falabella.Entity
{
    public class MetaRollRatesDiario
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public int Dia { get; set; }
        public int Tramo { get; set; }
        public double Meta { get; set; }
    }
}