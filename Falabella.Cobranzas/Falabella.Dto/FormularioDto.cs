using System.Collections.Generic;

namespace Falabella.Dto
{
    public class FormularioDto
    {
        public int Id { get; set; }
        public string ResourceKey { get; set; }
        public string Direccion { get; set; }
        public string Icono { get; set; }
        public int Orden { get; set; }
        public int? FormularioParentId { get; set; }
        public List<PermisoFormularioDto> PermisoList { get; set; }
        public List<FormularioDto> FormulariosHijosList { get; set; }

        public string Area 
        {
            get
            {
                var partes = Direccion.Split('/');
                if (partes.Length == 4) return partes[1];
                return string.Empty;
            }
        }

        public string Controlador
        {
            get
            {
                var partes = Direccion.Split('/');
                if (partes.Length == 4) return partes[2];
                return string.Empty;
            }
        }

        public string Accion
        {
            get
            {
                var partes = Direccion.Split('/');
                if (partes.Length == 4) return partes[3];
                return string.Empty;
            }
        }
    }
}