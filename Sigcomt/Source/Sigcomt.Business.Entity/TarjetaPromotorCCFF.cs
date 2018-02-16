namespace Sigcomt.Business.Entity
{
    public class TarjetaPromotorCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public int CuotaEntregas { get; set; }
        public int TarjetasEntregadas { get; set; }
        public decimal ProyeccionCumplida { get; set; }

    }
}
