using System;

namespace Falabella.Entity
{
    public class MetaRefinanciado
    {
        public DateTime FechaMeta { get; set; }
        public double Meta { get; set; }
        public double IntervaloInferior { get; set; }
        public double IntervaloSuperior { get; set; }
        public double? IntervaloSeleccionado { get; set; }
    }
}