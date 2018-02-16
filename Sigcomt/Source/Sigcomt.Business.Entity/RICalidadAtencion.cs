namespace Sigcomt.Business.Entity
{
    public class RICalidadAtencion
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public decimal SumaResRel { get; set; }
        public decimal SumaOBJRel { get; set; }
        public decimal SumaPorcRel { get; set; }
        public decimal SumaResCCFF { get; set; }
        public decimal SumaOBJCCFF { get; set; }
        public decimal SumaPorcEECC { get; set; }
        public decimal SumaResCaj { get; set; }
        public decimal SumaOBJCaj { get; set; }
        public decimal SumaPorcCaj { get; set; }
        public decimal SumaResPro { get; set; }
        public decimal SumaOBJPro { get; set; }
        public decimal SumaPorcPro { get; set; }
        public decimal SumaResTotal { get; set; }
        public decimal SumaOBJTotal { get; set; }
        public decimal SumaPorcTotal { get; set; }
    }
}

