namespace Sigcomt.Business.Entity
{
    public class RIPasivosCortoLargoPlazo
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string CCFFId { get; set; }
        public string CCFF { get; set; }
        public decimal ResultadoCP { get; set; }
        public decimal MetaCP { get; set; }
        public decimal CumplimientoCP { get; set; }
        public decimal ResultadoLP { get; set; }
        public decimal MetaLP { get; set; }
        public decimal CumplimientoLP { get; set; }
    }
}
