namespace Sigcomt.Business.Entity
{
    public class RICalidadNPSCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Calculo { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public int Zona { get; set; }
        public decimal DET { get; set; }
        public decimal PAS { get; set; }
        public decimal PRO { get; set; }
        public decimal Total { get; set; }
        public decimal NPS { get; set; }
    }
}
