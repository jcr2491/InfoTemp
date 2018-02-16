using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class SodimacGanadorRepicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Sucursal { get; set; }
        public string Empleado { get; set; }
        public int Codigo { get; set; }
        public decimal MontoRapicash { get; set; }
        public string Tienda { get; set; }
        public string Cargo { get; set; }
        public decimal MontoBono { get; set; }


    }
}
