namespace Sigcomt.Business.Entity
{
    public class DetalleTottusRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public string CodigoEmpleado { get; set; }
        public string Empleado { get; set; }
        public decimal Monto { get; set; }

    }
}
