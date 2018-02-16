namespace Sigcomt.Common
{
    public class ResponseError
    {
        public string Reporte { get; set; }
        public int Id { get; set; }
        public int TipoComisionId { get; set; }
        public string TipoComision { get; set; }
        public string Input { get; set; }
        public int Secuencia { get; set; }
        public int TipoArchivoId { get; set; }
        public string TipoArchivo { get; set; }
        public int TipoValidacion  { get; set; }
        public int TipoError { get; set; }
        public string NombreHoja { get; set; }
        public int NumeroFila { get; set; }
        public int FilaId { get; set; }
        public string NombreCampo  { get; set; }
        public string Mensaje { get; set; }
        public int PosicionColumna { get; set; }
        public string NombreColumna { get; set; }
    }
}
