using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
  public  class PlanillaTottusRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaId { get; set; }
        public string Tienda { get; set; }
        public int CodCCFF { get; set; }
        public string Unidad { get; set; }
        public string Puesto { get; set; }
        public string Codigo { get; set; }
        public string Tipo { get; set; }
        public string Colaborador { get; set; }
     
    }
}
