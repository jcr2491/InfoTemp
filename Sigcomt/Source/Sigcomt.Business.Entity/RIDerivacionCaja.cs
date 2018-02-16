namespace Sigcomt.Business.Entity
{
    public class RIDerivacionCaja
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string CCFFId { get; set; }
        public string CCFF { get; set; }
        public string Zona { get; set; }
        public double AtencionesCaja { get; set; }
        public double MetaRetiros { get; set; }
        public double MetaPagoTC { get; set; }
        public double PagoTC { get; set; }
        public double RetirosTCCajaPIF { get; set; }
        public double RetirosTDCajaPIF { get; set; }
        public double RetirosCajaPIF { get; set; }
    }
}
