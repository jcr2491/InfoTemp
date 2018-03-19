namespace Sigcomt.Business.Entity
{
    public class ResumenTottusRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaId { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public decimal MetaMes { get; set; }
        public decimal Logro { get; set; }
        public decimal Cumplimiento { get; set; }

    }
}
