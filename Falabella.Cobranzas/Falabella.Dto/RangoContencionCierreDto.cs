using System;

namespace Falabella.Dto
{
    public class RangoContencionCierreDto
    {
        public int PaisId { get; set; }
        public int Rango { get; set; }
        public int DiaMoraMin { get; set; }
        public int? DiaMoraMax { get; set; }
        public bool EsTemporal { get; set; }
    }
}