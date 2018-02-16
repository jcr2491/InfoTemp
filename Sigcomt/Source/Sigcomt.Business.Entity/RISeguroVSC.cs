using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class RISeguroVSC
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public decimal VidaSNeto { get; set; }
        public decimal VidaSCuota { get; set; }
    }
}
