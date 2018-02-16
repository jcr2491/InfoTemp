namespace Sigcomt.Business.Entity
{
    public  class CierrePlanningJefeComercial
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public decimal CalidadTELogro { get; set; }
        public decimal CalidadTEMeta { get; set; }
        public decimal CalidadCILogro { get; set; }
        public decimal CalidadCIMeta { get; set; }
        public decimal CalidadCIResultado { get; set; }
        public decimal CalidadCIPromotorLogro { get; set; }
        public decimal CalidadCIPromotorMeta { get; set; }
        public decimal CalidadCIPromotorResultado { get; set; }
        public decimal CalidadCIEECCPromotorLogro { get; set; }
        public decimal CalidadCIEECCPromotorMeta { get; set; }
        public decimal CalidadCIEECCPromotorResultado { get; set; }
        public decimal CalidadNPSLogro { get; set; }
        public decimal CalidadNPSMeta { get; set; }
        public decimal CalidadNPSResultado { get; set; }
        public decimal TarjetaCMRCSTPPLogro { get; set; }
        public decimal TarjetaCMRCSTPPMeta { get; set; }
        public decimal ActivoPasivoCPLogro { get; set; }
        public decimal ActivoPasivoCPMeta { get; set; }
        public decimal ActivoCVLogro { get; set; }
        public decimal ActivoCVMeta { get; set; }
        public decimal PasivoTarjetaCLogro { get; set; }
        public decimal PasivoTarjetaCMeta { get; set; }
        public decimal PasivoCSALogro { get; set; }
        public decimal PasivoCSAMeta { get; set; }
        public decimal CrucePAPLogro { get; set; }
        public decimal CrucePAPMeta { get; set; }
        public decimal CrucePEECCPLogro { get; set; }
        public decimal CrucePEECCPMeta { get; set; }

        public string Zona { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public int CodigoCCFF { get; set; }
        public string NombreCCFF { get; set; }
        public string Cargo { get; set; }
    }
}
