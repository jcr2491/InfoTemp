using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sigcomt.Business.Entity
{
    public class RITarjetaAdicional
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public decimal LogroAdicional { get; set; }
        public decimal Meta { get; set; }
        public decimal Activacion { get; set; }
    }
}