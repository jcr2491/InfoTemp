using System;

namespace Falabella.Entity
{
    public class EstudioRecuperoCastigo
    {
        public int CabeceraCargaId { get; set; }
        public int Secuencia { get; set; }
        public DateTime Fecha { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public int TipoEstudioId { get; set; }
        public string CodigoAuxiliar { get; set; }
        public int RegionId { get; set; }
        public int? Grupo { get; set; }
    }
}