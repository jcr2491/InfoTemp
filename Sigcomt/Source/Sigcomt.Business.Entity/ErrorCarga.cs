namespace Sigcomt.Business.Entity
{
    public class ErrorCarga
    {
        public int CargaId { get; set; }
        public int Fila { get; set; }
        public int PosicionColumna { get; set; }
        public string NombreColumna { get; set; }
        public string DetalleError { get; set; }
    }
}