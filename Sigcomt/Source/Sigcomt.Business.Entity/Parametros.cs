
using System;

namespace Sigcomt.Business.Entity
{
    public class Parametros
    {
        public int Id { get; set; }   
        public string Codigo { get; set; }
        public int TipoComision { get; set; }
        public DateTime FechaVigencia { get; set; }
        public bool Estado { get; set; }
        public string Descripcion { get; set; }
        public int ValorNumerico { get; set; }
        public string ValorTexto { get; set; }
        public double ValorDecimal { get; set; }
        public bool ValorBoleano { get; set; }
        public DateTime ValorFecha { get; set; }

    }
}
