using Sigcomt.Business.Entity.Core;
using System.Collections.Generic;

namespace Sigcomt.Business.Entity
{
    public class Tabla: EntityBase<int>
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public IList<ItemTabla> ItemTabla { get; set; }
    }
}
