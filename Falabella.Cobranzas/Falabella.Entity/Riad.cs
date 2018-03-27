using System;

namespace Falabella.Entity
{
    public class Riad
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public string NroCuenta { get; set; }
        public string CSbs { get; set; }
        public int TipoDoc { get; set; }
        public string NroDoc { get; set; }
        public string Nombres { get; set; }
        public string SubProducto { get; set; }
        public int DiasMora { get; set; }
        public string EstadoCuenta { get; set; }
        public string CatProducto { get; set; }
        public string CatInterna { get; set; }
        public string CatSbs { get; set; }
        public string CatExterna { get; set; }
        public decimal Capital { get; set; }
        public decimal ProvAlineada { get; set; }
        public decimal ProvInterna { get; set; }
        public string TipoCredito { get; set; }
        public int? Tienda { get; set; }
        public string FolioErrado { get; set; }
        public bool EsTarjetaCredito { get; set; }
    }
}