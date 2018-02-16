using Sigcomt.Business.Entity.Core;

namespace Sigcomt.Business.Entity
{
    public class ItemTabla: EntityBase<int>
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Valor { get; set; }
        public int TablaId { get; set; }
        public Tabla Tabla { get; set; }
    }
}
