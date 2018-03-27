using System;

namespace Falabella.Entity
{
    public class EstudioMetaTramo
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public string Estudio { get; set; }
        public int Tramo { get; set; }
        public decimal Meta { get; set; }
    }
}