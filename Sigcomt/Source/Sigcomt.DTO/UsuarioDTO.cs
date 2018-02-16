using Sigcomt.DTO.Core;

namespace Sigcomt.DTO
{
    public class UsuarioDTO: EntityAuditableDTO<int>
    {
        public string Username { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Correo { get; set; }
        public int CargoId { get; set; }
        public int RolId { get; set; }
        public string RolNombre { get; set; }
    }
}
