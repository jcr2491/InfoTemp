namespace Sigcomt.Business.Entity
{
    public class RISeguroCCFF
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int CCFFId { get; set; }
        public string Zona { get; set; }
        public string Tienda { get; set; }
        public decimal TPNetoEC { get; set; }
        public decimal TPNetoCP { get; set; }
        public decimal TPNetoPR { get; set; }
        public decimal TPCuotaCP { get; set; }
        public decimal TPCuotaPR { get; set; }
        public decimal VidaSNeto { get; set; }
        public decimal VidaSCuota { get; set; }
    }
}
