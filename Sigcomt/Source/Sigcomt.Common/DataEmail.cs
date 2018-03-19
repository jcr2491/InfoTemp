using Sigcomt.Business.Entity;
using System.Collections.Generic;

namespace Sigcomt.Common
{
    public class DataEmail
    {
        public string HoraEjecucion { get; set; }
        public int ArchivosCorrecto { get; set; }
        public int ArchivosIncorrecto { get; set; }
        public string Ruta { get; set; }
        public List<Archivo> ArchivosEstado { get; set; }
                                        

    }
}
