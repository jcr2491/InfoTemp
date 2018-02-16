using System.Collections.Generic;

namespace Sigcomt.Business.Entity
{
    public class Excel
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Ruta { get; set; }
        public int TipoCarga { get; set; }
        public virtual ICollection<ExcelHoja> HojasList { get; set; }
    }
}