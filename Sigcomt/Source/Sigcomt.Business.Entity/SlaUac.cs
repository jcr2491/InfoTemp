namespace Sigcomt.Business.Entity
{
    public class SlaUac
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int SupervisorId { get; set; }
        public string Supervisor { get; set; }
        public string GrupoId { get; set; }
        public string Grupo { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public decimal FueraPlazo { get; set; }
        public decimal DentroPlazo { get; set; }
        public decimal TotalGeneral { get; set; }
    }
}