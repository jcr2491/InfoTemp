namespace Sigcomt.Business.Entity
{
    public class RIAmpliacionLinea
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId  { get; set; }
        public string CCFF { get; set; }
        public decimal ALogro { get; set; }
        public decimal AMeta { get; set; }
        public decimal ACumplimiento { get; set; }
    }
}
