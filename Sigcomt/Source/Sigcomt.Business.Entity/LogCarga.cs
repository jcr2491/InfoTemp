using System;

namespace Sigcomt.Business.Entity
{
    public class LogCarga
    {
        public DateTime FechaLog { get; set; }
        public int Secuencia { get; set; }
        public string TipoLog { get; set; }
        public int? CargaId { get; set; }
        public string TipoArchivo { get; set; }
        public int? NumFila { get; set; }
        public string PosicionColumna { get; set; }
        public int? ExcelHojaCampoId { get; set; }        
        public string DetalleLog { get; set; }
        public string NombreCampo { get; set; }
    }
}