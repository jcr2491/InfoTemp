namespace Sigcomt.Business.Entity
{
    public class RICalidadCICCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public int LogroREL { get; set; }
        public int MetaREL { get; set; }
        public double PorcentajeLogroREL { get; set; }
        public int LogroEECC { get; set; }
        public int MetaEECC { get; set; }
        public double PorcentajeLogroEECC { get; set; }
        public int LogroCAJ { get; set; }
        public int MetaCAJ { get; set; }
        public double PorcentajeLogroCAJ { get; set; }
        public int LogroPRO { get; set; }
        public int MetaPRO { get; set; }
        public double PorcentajeLogroPRO { get; set; }
        public int LogroTotal { get; set; }
        public int MetaTotal { get; set; }
        public double PorcentajeLogroTotal { get; set; }
    }
}
