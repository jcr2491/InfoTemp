using System;

namespace Sigcomt.Business.Entity
{
    public class EmpleadoCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string CodigoEmpleado { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string CargoId { get; set; }
        public string Cargo { get; set; }
        public string SucursalId { get; set; }
        public string Sucursal { get; set; }
        public int ZonaId { get; set; }
        public string Zona { get; set; }
        public DateTime FechaIngreso { get; set; }
        public DateTime FechaCese { get; set; }
        public string Estado { get; set; }
        public int SubEstadoId { get; set; }
        public string SubEstado { get; set; }
    }
}