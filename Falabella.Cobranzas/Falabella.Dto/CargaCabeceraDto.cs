namespace Falabella.Dto
{
    public class CargaCabeceraDto
    {
        public int Id { get; set; }
        public string TipoArchivo { get; set; }
        public string DescripcionTipoArchivo { get; set; }
        public string FechaArchivo { get; set; }
        public string FechaCargaIni { get; set; }
        public string TiempoCarga { get; set; }
        public int EstadoCarga { get; set; }
        public string DescripcionEstadoCarga { get; set; }
    }
}