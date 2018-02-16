namespace Sigcomt.Business.Entity
{
    public class PuntajeKPI
    {
        public int KpiId  { get; set; }
        public int CargaId { get; set; }
        public int CargoId { get; set; }
        public decimal CumplimientoIni { get; set; }
        public decimal CumplimientoFin { get; set; }
        public decimal Puntaje { get; set; }
        public decimal Comision { get; set; }
        public decimal PorcentajeIndividual { get; set; }
    }
}
