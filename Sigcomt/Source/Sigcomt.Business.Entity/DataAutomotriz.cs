using System;

namespace Sigcomt.Business.Entity
{
    public class DataAutomotriz
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
        public int NroPrestamo { get; set; }
        public string TipoDoc { get; set; }
        public int Documento { get; set; }
        public string Empleado { get; set; }
        public DateTime FechaDesembolso { get; set; }
        public string Canal { get; set; }
        public string Captacion { get; set; }
        public string Promotor { get; set; }
        public string Asistente { get; set; }
        public string TipoSeguro { get; set; }
        public string Moneda { get; set; }
        public double Precio { get; set; }
        public double CuotaInicial { get; set; }
        public double Monto { get; set; }
        public string Intermediacion { get; set; }        
    }
}
