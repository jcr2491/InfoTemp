namespace Sigcomt.Business.Entity
{
    public class Empleado
    {
        public int Id { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string NombreCorto { get; set; }
        public string NomCalidar { get; set; }
        public string NomData { get; set; }
        public string NomGesco { get; set; }
        public string NomProducSLA { get; set; }
        public int CargoId { get; set; }
        public string Cargo { get; set; }
    }
}