using System.Collections.Generic;

namespace Falabella.Dto
{
    public class ContencionCierreDto
    {
        public string Fecha { get; set; }
        public bool IncluirHistorico { get; set; }
        public bool SoloHistorico { get; set; }
        public List<RangoContencionCierreDto> Rangos { get; set; }
    }
}