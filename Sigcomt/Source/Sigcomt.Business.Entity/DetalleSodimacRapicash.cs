namespace Sigcomt.Business.Entity
{
    public class DetalleSodimacRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Sucursal { get; set; }
        public string CodCajero { get; set; }
        public string Cajero { get; set; }
        public double Total { get; set; }
    }
}
