using System;

namespace Sigcomt.Business.Entity
{
    public class RIOperacionSF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string OPCodigo { get; set; }
        public string OPNombre { get; set; }
        public int OPCodCCFF { get; set; }
        public string OPCCFF { get; set; }
        public DateTime OPFechaRegistro { get; set; }
        
    }
}
