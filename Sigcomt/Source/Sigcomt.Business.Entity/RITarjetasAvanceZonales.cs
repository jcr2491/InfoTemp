namespace Sigcomt.Business.Entity
{
    public class RITarjetasAvanceZonales
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int Nro { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public string Zona { get; set; }
        public decimal CuotaAprobada { get; set; }
        public decimal SolicitudesAprobadas { get; set; }
        public decimal CuotaEntrega{ get; set; }
        public decimal TarjetasEntregadas { get; set; }
    }
}
