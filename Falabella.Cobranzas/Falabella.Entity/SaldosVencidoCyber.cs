using System;

namespace Falabella.Entity
{
    public class SaldosVencidoCyber
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Informacional { get; set; }
        public string NroCuenta { get; set; }
        public int SituacionCuenta { get; set; }
        public int DiaVencimiento { get; set; }
        public decimal MontoMora { get; set; }
        public decimal SaldoDeuda { get; set; }
        public decimal Capital { get; set; }
        public decimal? MontoAcelerado { get; set; }
        public DateTime? FechaAceleracion { get; set; }
        public int DiasMora { get; set; }
        public int? EtapaMora { get; set; }
        public DateTime InicioMora { get; set; }
        public string HabitoPago { get; set; }
        public string ColaActual { get; set; }
        public string Agencia { get; set; }
        public DateTime FechaAsignacion { get; set; }
        public int? Behavior { get; set; }
        public int? Bar { get; set; }
        public string CodSubProducto { get; set; }
        public string Ubigeo { get; set; }
        public string Pan { get; set; }
        public string Celular { get; set; }
        public string FonoCasa { get; set; }
        public int TipoDoc { get; set; }
        public string NroDoc { get; set; }
        public int CondicionCliente { get; set; }
        public bool Empleado { get; set; }
        public DateTime? FechaProxContacto { get; set; }
        public DateTime? UltimaFechaPago { get; set; }
        public decimal? UltimoMontoPagado { get; set; }
        public DateTime? Venc1 { get; set; }
        public DateTime? Venc2 { get; set; }
        public DateTime? Venc3 { get; set; }
        public DateTime? Venc4 { get; set; }
        public decimal? Cuota1 { get; set; }
        public decimal? Cuota2 { get; set; }
        public decimal? Cuota3 { get; set; }
        public decimal? Cuota4 { get; set; }
        public decimal? SaldoSuperCash { get; set; }
        public string Cola3 { get; set; }
        public DateTime? FechaRefinanciacion { get; set; }
        public string Cedente { get; set; }
    }
}