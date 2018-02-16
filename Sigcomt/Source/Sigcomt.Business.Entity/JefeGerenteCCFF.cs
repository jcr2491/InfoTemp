using System;

namespace Sigcomt.Business.Entity
{
    public class JefeGerenteCCFF
    {
        public DateTime Fecha { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public int EmpleadoId { get; set; }
        public int EmpleadoCodigo { get; set; }
        public string Empleado { get; set; }
        public int CargoId { get; set; }
        public int CargoCodigo { get; set; }
        public int Cargo { get; set; }
        public int DiasLaborados { get; set; }
        public DateTime FechaIngreso { get; set; }
        public DateTime FechaCese { get; set; }
        public int Vacaciones { get; set; }
        public int DM { get; set; }
        public int Lic { get; set; }
        public int Maternidad { get; set; }
        public string UsuarioRed { get; set; }
        public string UsuarioRedJefe { get; set; }

    }
}
