using System;

namespace Sigcomt.Business.Entity
{
    public class DetalleErrorCarga
    {
        public DateTime FechaError { get; set; }
        public string TipoError { get; set; }
        public string NumFila { get; set; }
        public string PosicionColumna { get; set; }
        public string TipoArchivo { get; set; }
        public string DetalleError { get; set; }
    }
}