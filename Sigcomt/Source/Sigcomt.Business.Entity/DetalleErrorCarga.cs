using System;

namespace Sigcomt.Business.Entity
{
    public class DetalleErrorCarga
    {
        public DateTime FechaError { get; set; }
        public string TipoError { get; set; }
        public int NumFila { get; set; }
        public string PosicionColumna { get; set; }
        public string TipoArchivo { get; set; }
        public string DetalleError { get; set; }
        public string IdTipoArchivo { get; set; }
        public string TipoComision { get; set; }
        public int IdTipoComision { get; set; }
    }
}