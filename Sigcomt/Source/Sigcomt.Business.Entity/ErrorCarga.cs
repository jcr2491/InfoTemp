using System;

namespace Sigcomt.Business.Entity
{
    public class ErrorCarga
    {
        public DateTime FechaError { get; set; }
        public int Secuencia { get; set; }
        public string TipoError { get; set; }
        public int? CargaId { get; set; }
        public int? NumFila { get; set; }
        public string PosicionColumna { get; set; }
        public int? ExcelHojaCampoId { get; set; }        
        public string DetalleError { get; set; }
    }
}