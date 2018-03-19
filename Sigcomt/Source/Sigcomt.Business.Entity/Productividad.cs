namespace Sigcomt.Business.Entity
{
    public class Productividad
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int GrupoId { get; set; }
        public string Grupo { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public int DiasAsistencia { get; set; }
        public decimal TotalProductividad { get; set; }
        public decimal Logro { get; set; }
        public decimal MetaDiaria { get; set; }
        public decimal MetaReal { get; set; }
        public decimal APPAND { get; set; }
    }
}