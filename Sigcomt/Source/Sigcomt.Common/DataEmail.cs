using System.Collections.Generic;

namespace Sigcomt.Common
{
    public class DataEmail
    {
        public string HoraEjecucion { get; set; }
        public string Reporte { get; set; }
        public string Mes { get; set; }
        public List<ResponseError> ErrorList { get; set; }
    }
}
