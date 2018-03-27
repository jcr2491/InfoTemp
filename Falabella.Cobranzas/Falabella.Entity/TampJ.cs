using System;

namespace Falabella.Entity
{
    public class TampJ
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public string CodGesto { get; set; }
        public string NroCuenta { get; set; }
        public int Dias { get; set; }
        public string NumeroTarjeta { get; set; }
        public decimal SaldoDeuda { get; set; }
        public decimal MontoProtesto { get; set; }
        public decimal Capital { get; set; }
        public decimal InteresJudicial { get; set; }
        public decimal CargoJudicial { get; set; }
        public decimal InteresMorator { get; set; }
        public decimal CargoCobranza { get; set; }
        public int? Situacion { get; set; }
        public DateTime FechaProtes { get; set; }
        public DateTime FechaCastig { get; set; }
        public DateTime FechaAsigna { get; set; }
        public int TipoDocumento { get; set; }
        public string NroDocumento { get; set; }
        public string DireccionParticular { get; set; }
        public string DistritoParticular { get; set; }
        public string UbigeoParticular { get; set; }
        public string DireccionComercial { get; set; }
        public string DistritoComercial { get; set; }
        public string Ubigeo { get; set; }
        public string Celular { get; set; }
        public string TelfParticular { get; set; }
        public string TelfComercial { get; set; }
        public string CorreoParticular { get; set; }
        public string CorreoComercial { get; set; }
        public DateTime InformacionAl { get; set; }
        public string Col1 { get; set; }
        public string Col2 { get; set; }
        public string NombreCompleto { get; set; }
        public string NombreEmpresa { get; set; }
        public DateTime FechaUltimo { get; set; }
        public decimal MontoUltimoPago { get; set; }
        public decimal InteresCompens { get; set; }
        public string DeptoParticular { get; set; }
        public string ProvinciaParticular { get; set; }
        public string DeptoComercial { get; set; }
        public string ProvinciaComercial { get; set; }
    }
}