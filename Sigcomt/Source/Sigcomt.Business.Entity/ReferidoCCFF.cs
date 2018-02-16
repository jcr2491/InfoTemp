using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class ReferidoCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public string Fecha { get; set; }
        public string Colaborador { get; set; }
        public string Estado { get; set; }
        public int Cod_Colaborador { get; set; }
        public string TiendaRetail { get; set; }
    }
}
