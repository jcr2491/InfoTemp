using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
     public class RIParticipacion
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaRatail { get; set; }
        public string TiendaId { get; set; }
        public string Tienda { get; set; }
        public decimal VentaTotal { get; set; }
        public decimal VentaCMR { get; set; }
        public decimal ParticipacionCMR { get; set; }
        public decimal CMRMeta { get; set; }
        public decimal DiferenciaParticipacionMeta { get; set; }
        public decimal MetaVentaTotal { get; set; }
        public decimal MetaVentaCMR { get; set; }
    }
}
