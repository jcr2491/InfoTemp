namespace Sigcomt.Business.Entity
{
    public class RITECajero
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TECCFFId { get; set; }
        public string TECCFF { get; set; }
        public decimal TECajeroAten_10Min { get; set; }
        public decimal TECajeroTotalAten { get; set; }
        public decimal TECajeroLogro { get; set; }
        public decimal TECajeroMeta { get; set; }


    }
}
