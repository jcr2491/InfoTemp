namespace Falabella.Dto
{
    public class PermisoFormularioDto
    {
        public int FormularioId { get; set; }
        public int TipoPermiso { get; set; }
        public int Seccion { get; set; }
        public string NombrePermiso { get; set; }
        public int Estado { get; set; }
    }
}