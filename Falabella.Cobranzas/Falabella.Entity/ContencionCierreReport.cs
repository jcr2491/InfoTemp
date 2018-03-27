namespace Falabella.Entity
{
    public class ContencionCierreReport
    {
        public int PaisId { get; set; }
        public int Rango { get; set; }
        public int DiaMoraMin { get; set; }
        public int? DiaMoraMax { get; set; }
        public double SumTotal { get; set; }
        public double SumContenido { get; set; }
        public int NumContenido { get; set; }
        public double SumNoContenido { get; set; }
        public int NumNoContenido { get; set; }
        public double SumPagoTotal { get; set; }
        public int NumPagoTotal { get; set; }
        public double SumRenegociada { get; set; }
        public int NumRenegociada { get; set; }
        public double SumPagoCuotaAtrasada { get; set; }
        public int NumPagoCuotaAtrasada { get; set; }
    }
}