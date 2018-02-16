using Sigcomt.Business.Entity.Core;

namespace Sigcomt.Business.Entity
{
    public class Rol: EntityBase<int>
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }
}
