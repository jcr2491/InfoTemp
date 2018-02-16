
namespace Sigcomt.Business.Entity
{
    public class DetalleMaestroRapicash
    {
        public int CargaId { get; set; }
        public int Secuencia { get; set; }
       // public int SucursalId { get; set; }
        public string Sucursal { get; set; }
        public int Anio { get; set; }
        public int Mes { get; set; }
        public int DiaCompraoRetiro { get; set; }
        public int DiaProceso { get; set; }
        public string Cargo { get; set; }
        public string NombreEmpleado { get; set; }
        public string CodEmpleado { get; set; }
        public string Transaccion { get; set; }
        public string Tipo { get; set; }
        public int Monto { get; set; }
        public int POS { get; set; }

    }
}
