namespace Sigcomt.Business.Entity
{
    public class MontosTrasladosCTS
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int EmpleadoId { get; set; }
        public string NombreCorto { get; set; }
        public int NroAperturas { get; set; }
        public int NroTransferencias { get; set; }
        public double MontoTotal { get; set; }
    }
}
