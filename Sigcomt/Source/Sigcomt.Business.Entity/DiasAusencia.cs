namespace Sigcomt.Business.Entity
{
    public class DiasAusencia
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int EmpleadoId { get; set; }      
        public string Empleado { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public double TotDiasNoLabor { get; set; }       

    }
}
