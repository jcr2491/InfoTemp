using System.Collections.Generic;
using Sigcomt.Business.Entity;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IParametroRepository
    {
        Parametros GetParametros(string CodigoParametro);
    }
}
