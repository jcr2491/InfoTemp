using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class CajeroTottusRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaId { get; set; }
        public string Tienda { get; set; }
        public string planilla { get; set; }
        public string Puesto { get; set; }
        public string CodigoEmpleado { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Nombres { get; set; }
        public string Estado { get; set; }

    }
}
