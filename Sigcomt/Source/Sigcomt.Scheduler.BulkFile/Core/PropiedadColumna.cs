namespace Sigcomt.Scheduler.BulkFile.Core
{
    public class PropiedadColumna
    {
        public int ExcelHojaCampoId { get; set; }
        public int PosicionColumna { get; set; }
        public string TipoDato { get; set; }
        public bool PermiteNulo { get; set; }
        public string Valor { get; set; }
        public string ValorDefecto { get; set; }
        public string ValorIgnorar { get; set; }
    }
}