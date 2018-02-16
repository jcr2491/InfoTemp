using System;

namespace Sigcomt.Business.Entity
{
    public class RIOperacionE
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int OPCCFFId { get; set; }
        public string OPMoneda { get; set; }   
        public int OPAnio { get; set; }
        public int OPMes { get; set; }
    }
}
