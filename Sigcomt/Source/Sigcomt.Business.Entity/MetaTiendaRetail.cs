namespace Sigcomt.Business.Entity
{
    public class MetaTiendaRetail
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaId { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public double MetaMes { get; set; }
        public double Logro { get; set; }
        public double Cumplimiento { get; set; }
    }
}
