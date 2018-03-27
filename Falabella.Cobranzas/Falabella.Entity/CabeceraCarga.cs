using System;

namespace Falabella.Entity
{
    public class CabeceraCarga
    {
        public int Id { get; set; }
        public string TipoArchivo { get; set; }
        public DateTime FechaArchivo { get; set; }
        public DateTime FechaCargaIni { get; set; }
        public DateTime? FechaCargaFin { get; set; }
        public int EstadoCarga { get; set; }
    }
}