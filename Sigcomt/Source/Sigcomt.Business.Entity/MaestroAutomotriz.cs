namespace Sigcomt.Business.Entity
{
    public class MaestroAutomotriz
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int TipoComision { get; set; }
        public int CodigoEmpleado { get; set; }
        public string Empleado { get; set; }
        public int CargoId { get; set; }
        public decimal Meta { get; set; }
        public decimal CumplimientoInicio { get; set; }
        public decimal CumplimientoFin { get; set; }
        public decimal Comision { get; set; }
        public decimal SinSeguro { get; set; }
        public decimal ConSeguro { get; set; }
        public decimal Intermediacion { get; set; }
    }
}
