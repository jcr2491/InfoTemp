namespace Sigcomt.Business.Entity
{
    public class ExcelHojaCampo
    {
        public int Id { get; set; }
        public int ExcelHojaId { get; set; }
        public string NombreCampo { get; set; }
        public string PosicionColumna { get; set; }
        public string TipoDato { get; set; }
        public bool PermiteNulo { get; set; }
        public string ValorDefecto { get; set; }
        public string ValorIgnorar { get; set; }
    }
}