using System;

namespace Falabella.Entity
{
    public class PagoHc
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime FechaPago { get; set; }
        public string NroCuenta { get; set; }
        public string Descripcion { get; set; }
        public decimal Monto { get; set; }
    }
}