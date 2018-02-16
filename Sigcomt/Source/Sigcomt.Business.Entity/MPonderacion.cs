using System;

namespace Sigcomt.Business.Entity
{
    public class MPonderacion
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Semana { get; set; }
        public int Mes { get; set; }
        public DateTime FechaMuestra { get; set; }
        public int Incidente { get; set; }
        public int EspecialistaId { get; set; }
        public string NomEspecialista { get; set; }
        public string Proceso { get; set; }
        public string TipoMonitoreo { get; set; }
        public double CR1 { get; set; }
        public double CR2 { get; set; }
        public double CR3 { get; set; }
        public double CR4 { get; set; }
        public double CR5 { get; set; }
        public double CR6 { get; set; }
        public double CR7 { get; set; }
        public double CRSuma { get; set; }
        public double CS1 { get; set; }
        public double CS2 { get; set; }
        public double CSSuma { get; set; }
        public double CP1 { get; set; }
        public double CPSuma { get; set; }
        public double OR1 { get; set; }
        public double OR2 { get; set; }
        public double ORSuma { get; set; }
        public double VR1 { get; set; }
        public double VR2 { get; set; }
        public double VR3 { get; set; }
        public double VR4 { get; set; }
        public double VRSuma { get; set; }
        public double MR1 { get; set; }
        public double MR2 { get; set; }
        public double MR3 { get; set; }
        public double MRSuma { get; set; }
        public double Nota { get; set; }
        public string CumpleEstand { get; set; }




    }
}
