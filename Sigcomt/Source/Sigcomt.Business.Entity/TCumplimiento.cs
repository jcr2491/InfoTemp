namespace Sigcomt.Business.Entity
{
    public class TCumplimiento
    {
        public int CargaId { get; set; }
        public string CodTipo { get; set; }
        public int Secuencia { get; set; }
        public string NomTabla { get; set; }
        public double Inicio { get; set; }
        public double Fin { get; set; }
        public double Cumplimiento { get; set; }
        public double Puntaje { get; set; }
        public double Premio { get; set; }
        public string GestionIndivGrupal { get; set; }
    }
}
