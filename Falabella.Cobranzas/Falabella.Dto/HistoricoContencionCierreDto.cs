namespace Falabella.Dto
{
    public class HistoricoContencionCierreDto
    {
        public string Fecha { get; set; }
        public int PaisId { get; set; }
        public int Rango { get; set; }
        public int DiaMoraMin { get; set; }
        public int DiaMoraMax { get; set; }
        public double Total { get; set; }
        public double PagoTotal { get; set; }
        public double Renegociada { get; set; }
        public double PagoCuotaAtrasada { get; set; }
    }
}