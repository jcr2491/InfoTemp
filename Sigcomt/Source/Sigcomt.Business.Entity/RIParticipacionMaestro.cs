namespace Sigcomt.Business.Entity
{
    public class RIParticipacionMaestro
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaRatail { get; set; }
        public int TiendaId { get; set; }
        public string Tienda { get; set; }
        public decimal VentaTotal { get; set; }
        public decimal VentaCMR { get; set; }
        public decimal ParticipacionCMR { get; set; }
        public decimal CMRMeta { get; set; }
        public decimal DiferenciaParticipacionMeta { get; set; }
    }
}
