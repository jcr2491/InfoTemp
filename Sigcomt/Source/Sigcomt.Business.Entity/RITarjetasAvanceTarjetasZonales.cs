namespace Sigcomt.Business.Entity
{
    public class RITarjetasAvanceTarjetasZonales
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int EmpleadoId { get; set; }
        public string Empleado { get; set; }
        public int TotalAtendido { get; set; }
        public int DiasLaborados { get; set; }
        public int MetaDiaria { get; set; }
        public int MetaMes { get; set; }
        public double Productividad { get; set; }
    }
}
