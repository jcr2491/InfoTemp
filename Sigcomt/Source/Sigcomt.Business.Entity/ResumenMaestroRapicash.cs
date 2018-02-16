namespace Sigcomt.Business.Entity
{
    public class ResumenMaestroRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public string Empleado { get; set; }
        public int CodEmpleado { get; set; }
        public string Cargo { get; set; }
        public double MontoRapicash { get; set; }
        public double MontoBono { get; set; }

    }
}
