using System;

namespace Falabella.Entity
{
    public class CastigoHc
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public string NroCuenta { get; set; }
        public string Sit { get; set; }
        public DateTime? FechaCastigo { get; set; }
        public bool Considerar { get; set; }
    }
}