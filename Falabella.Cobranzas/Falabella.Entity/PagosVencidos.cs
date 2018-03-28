using System;

namespace Falabella.Entity
{
    public class PagosVencidos
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan? Hora { get; set; }
        public string NroCuentaOrigen { get; set; }
        public string NroCreditoVencido { get; set; }
        public string Moneda { get; set; }
        public string Local { get; set; }
        public string Terminal { get; set; }
        public string CodigoPago { get; set; }
        public string Descripcion { get; set; }
        public decimal Monto { get; set; }
        public DateTime FechaRegularizacion { get; set; }
    }
}