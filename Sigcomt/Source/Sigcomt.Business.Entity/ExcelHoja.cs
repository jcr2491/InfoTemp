using System.Collections.Generic;

namespace Sigcomt.Business.Entity
{
    public class ExcelHoja
    {
        public int Id { get; set; }
        public int ExcelId { get; set; }
        public string TipoArchivo { get; set; }
        public int FilaIni { get; set; }
        public string NombreHoja { get; set; }
        public string Descripcion { get; set; }

        public virtual ICollection<ExcelHojaCampo> CampoList { get; set; }
    }
}