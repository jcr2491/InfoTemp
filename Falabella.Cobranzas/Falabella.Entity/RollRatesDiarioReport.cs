namespace Falabella.Entity
{
    public class RollRatesDiarioReport
    {
        public int Dia { get; set; }
        public int Tramo { get; set; }
        public double Meta { get; set; }
        public double? Aumenta { get; set; }
        public double? Total { get; set; }
        public double PorcentajeAumenta { get; set; }
        public bool EsContenido { get; set; }
    }
}