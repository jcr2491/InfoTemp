using System;

namespace Sigcomt.Business.Entity
{
    public class Monitoreo
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Semana { get; set; }
        public int Mes { get; set; }
        public DateTime FechaMuestra { get; set; }
        public int Incidente { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public string Proceso { get; set; }
        public string TipoMonitoreo { get; set; }
        public string CR1 { get; set; }
        public string CR2 { get; set; }
        public string CR3 { get; set; }
        public string CR4 { get; set; }
        public string CR5 { get; set; }
        public string CR6 { get; set; }
        public string CR7 { get; set; }        
        public string CS1 { get; set; }
        public string CS2 { get; set; }        
        public string CP1 { get; set; }        
        public string OR1 { get; set; }
        public string OR2 { get; set; }        
        public string VR1 { get; set; }
        public string VR2 { get; set; }
        public string VR3 { get; set; }
        public string VR4 { get; set; }        
        public string MR1 { get; set; }
        public string MR2 { get; set; }
        public string MR3 { get; set; } 

    }
}
