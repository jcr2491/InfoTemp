using Sigcomt.DTO.Core;
using System;

namespace Sigcomt.DTO
{
    public class LogDTO: EntityAuditableDTO<long>
    {
        public string Usuario { get; set; }
        public string Mensaje { get; set; }
        public string Controlador { get; set; }
        public string Accion { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string Objeto { get; set; }
        public int? Identificador { get; set; }
    }
}
