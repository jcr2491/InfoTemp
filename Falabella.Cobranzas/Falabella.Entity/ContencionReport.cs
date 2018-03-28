namespace Falabella.Entity
{
    public class ContencionReport
    {
        public int Dia { get; set; }
        public int Tramo { get; set; }
        public double Meta { get; set; }
        public bool EsContenido { get; set; }
        public double Contenido { get; set; }
        public double NoContenido { get; set; }
        public double PorcentajeContenido { get; set; }
        public double ContenidoAcumulado { get; set; }
    }
}