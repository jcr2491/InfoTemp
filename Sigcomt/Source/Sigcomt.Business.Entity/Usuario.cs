using Sigcomt.Business.Entity.Core;

namespace Sigcomt.Business.Entity
{
    public class Usuario: EntityAuditable<int>
    {
        public string Username { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Correo { get; set; }
        public int CargoId { get; set; }
        public int RolId { get; set; }
        public Rol Rol { get; set; }
    }
}
