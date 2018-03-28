using System;

namespace Falabella.Entity
{
    public class CuentasCastigoMensual
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public string NroCuenta { get; set; }
        public int DiasMoraActual { get; set; }
        public DateTime? FechaCastigo { get; set; }
        public decimal Capital { get; set; }
    }
}