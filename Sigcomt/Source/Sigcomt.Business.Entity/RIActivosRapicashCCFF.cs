using System;

namespace Sigcomt.Business.Entity
{
    public class RIActivosRapicashCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Zona { get; set; }
        public int CCFFId { get; set; }
        public string CCFF { get; set; }
        public double PifSolesLogro { get; set; }
        public double PifSolesMeta { get; set; }
        public double PifSolesLogroProy { get; set; }
        public double ATMSolesLogro { get; set; }
        public double ATMSolesMeta { get; set; }
        public double ATMSolesLogroProy { get; set; }
        public double TotalSolesLogro { get; set; }
        public double TotalSolesMeta { get; set; }
        public double TotalSolesLogroProy { get; set; }

    }
}
