using System;

namespace Falabella.Entity
{
    public class EstudioMetaRecupero
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public string Estudio { get; set; }
        public double Meta { get; set; }
    }
}