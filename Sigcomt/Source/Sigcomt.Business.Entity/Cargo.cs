using Sigcomt.Business.Entity.Core;

namespace Sigcomt.Business.Entity
{
    public class Cargo: EntityAuditable<int>
    {
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
    }
}