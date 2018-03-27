using System;

namespace Falabella.Entity
{
    public class Refinanciados
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public string NroCuenta { get; set; }
        public string EstadoActual { get; set; }
        public decimal SaldoCapital { get; set; }
        public DateTime FechaOperacion { get; set; }
    }
}