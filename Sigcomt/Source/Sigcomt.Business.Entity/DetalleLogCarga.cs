using System;
using System.Collections.Generic;

namespace Sigcomt.Business.Entity
{
    public class DetalleLogCarga
    {
        public DateTime FechaLog { get; set; }
        public string Archivo { get; set; } 
        public string TipoLog { get; set; }
        public int NumFila { get; set; }
        public string NombreCampo { get; set; }
        public string PosicionColumna { get; set; }
        public string TipoArchivo { get; set; }
        public string DetalleLog { get; set; }
        public string TipoArchivoId { get; set; }
        public string TipoComision { get; set; }
        public int TipoComisionId { get; set; }
        public string NombreArchivo { get; set; }
        public string NombreHoja { get; set; }
        public string NombreResponsable { get; set; }

    }
}