namespace Sigcomt.Business.Entity
{
    public class SLAContactenos
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public int DentroPlazo { get; set; }
        public int FueraPlazo { get; set; }
        public int TotalGeneral { get; set; }
        public double SLA { get; set; }
    }
}
