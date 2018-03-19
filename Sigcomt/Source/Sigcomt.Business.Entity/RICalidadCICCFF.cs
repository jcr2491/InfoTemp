namespace Sigcomt.Business.Entity
{
    public class RICalidadCICCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public decimal LogroREL { get; set; }
        public decimal MetaREL { get; set; }
        public decimal PorcentajeLogroREL { get; set; }
        public decimal LogroCCFF { get; set; }
        public decimal MetaCCFF { get; set; }
        public decimal PorcentajeLogroCCFF { get; set; }
        public decimal LogroEECC { get; set; }
        public decimal MetaEECC { get; set; }
        public decimal PorcentajeLogroEECC { get; set; }
        public decimal LogroCAJ { get; set; }
        public decimal MetaCAJ { get; set; }
        public decimal PorcentajeLogroCAJ { get; set; }
        public decimal LogroPRO { get; set; }
        public decimal MetaPRO { get; set; }
        public decimal PorcentajeLogroPRO { get; set; }
        public decimal LogroTotal { get; set; }
        public decimal MetaTotal { get; set; }
        public decimal PorcentajeLogroTotal { get; set; }
    }
}
