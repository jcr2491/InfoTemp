using System.Collections.Generic;

namespace Sigcomt.Common
{
    public class DataEmail
    {
        public string HoraEjecucion { get; set; }
        public List<ResponseError> ErrorList { get; set; }
        public List<ResponseInput> inputList { get; set; }
        public List<ResponseTipoComision> tipoComisionList { get; set; }

    }
}
