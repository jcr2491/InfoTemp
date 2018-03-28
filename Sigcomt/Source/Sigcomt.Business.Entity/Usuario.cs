using Sigcomt.Business.Entity.Core;

namespace Sigcomt.Business.Entity
{
    public class Usuario: EntityAuditable<int>
    {
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Username { get; set; }
        public string Clave { get; set; }
        public Rol Rol { get; set; }

        public string NombreCompleto => $"{Nombres} {Apellidos}";
    }
}