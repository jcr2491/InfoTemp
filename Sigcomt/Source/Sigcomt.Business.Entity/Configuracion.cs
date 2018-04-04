namespace Sigcomt.Business.Entity
{
    public class Configuracion
    {
        public int Id { get; set; }
        public string TipoConfiguracion { get; set; }
        public string Usuario { get; set; }
        public string Clave { get; set; }
        public string Host { get; set; }
        public int Puerto { get; set; }
    }
}