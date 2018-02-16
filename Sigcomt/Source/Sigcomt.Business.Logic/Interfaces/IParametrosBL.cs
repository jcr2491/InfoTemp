using System.Collections.Generic;
using Sigcomt.Business.Entity;


namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IParametrosBL
    {
        Parametros GetParametros(string CodigoParametro);
    }
}
