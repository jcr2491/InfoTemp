namespace Sigcomt.Business.Entity
{
    public class DerivacionCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public string Zona { get; set; }
        public int CCFFId { get; set; }
        public int NumResultadoRetiro { get; set; }
        public double NumMetaRetiro { get; set; }
        public int NumResultadoPagos { get; set; }
        public double NumMetaPagos { get; set; }

    }
}
