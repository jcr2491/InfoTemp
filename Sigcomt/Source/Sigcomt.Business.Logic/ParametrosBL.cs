using System.Collections.Generic;
using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class ParametrosBL : Singleton<ParametrosBL>, IParametrosBL
    {
        public Parametros GetParametros(string CodigoParametros)
        {
            return ParametroRepository.GetInstance().GetParametros(CodigoParametros);
        }
    }
}
