using System;

namespace Falabella.Entity
{
    public class CuentaHomologada
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime FechaCambio { get; set; }
        public string CuentaModificada { get; set; }
        public string CuentaOriginal { get; set; }
    }
}