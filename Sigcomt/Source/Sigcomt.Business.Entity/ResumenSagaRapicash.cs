namespace Sigcomt.Business.Entity
{
    public class ResumenSagaRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public double Meta { get; set; }
        public double VentaReal { get; set; }
        public double Cumplimiento { get; set; }
    }
}
