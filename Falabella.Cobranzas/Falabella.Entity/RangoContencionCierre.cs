using System;

namespace Falabella.Entity
{
    public class RangoContencionCierre
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public int Rango { get; set; }
        public int DiaMoraMin { get; set; }
        public int? DiaMoraMax { get; set; }
        public int PaisId { get; set; }
        public bool EsTemporal { get; set; }
    }
}