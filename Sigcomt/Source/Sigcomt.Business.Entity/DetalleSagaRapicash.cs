namespace Sigcomt.Business.Entity
{
    public class DetalleSagaRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public int CodCajero { get; set; }
        public string Cajero { get; set; }
        public int Total { get; set; }
    }
}
