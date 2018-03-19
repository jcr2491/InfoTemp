
namespace Sigcomt.Business.Entity
{
    public class GanadoresRetailRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TiendaId { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }              
        public string CodigoEmpleado { get; set; }
        public double MontoRapicash { get; set; }
        public int CargoId { get; set; }
        public string Cargo { get; set; }
        public double MontoBono { get; set; }

    }
}
