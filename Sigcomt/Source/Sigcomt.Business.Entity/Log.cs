using System;

namespace Sigcomt.Business.Entity
{
    public class Log
    {
        public long Id { get; set; }
        public string Usuario { get; set; }
        public string Mensaje { get; set; }
        public string Controlador { get; set; }
        public string Accion { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string Objeto { get; set; }
        public long? Identificador { get; set; }
    }
}