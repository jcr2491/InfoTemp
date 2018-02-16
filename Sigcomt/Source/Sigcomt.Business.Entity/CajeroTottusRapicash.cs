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
        public int Anio { get; set; }
        public int Mes { get; set; }
        public int TiendaId { get; set; }
        public string Tienda { get; set; }
        public string Plla { get; set; }
        public string Puesto { get; set; }
        public string Codigo { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Colaborador { get; set; }
        public string DNI { get; set; }

    }
}
