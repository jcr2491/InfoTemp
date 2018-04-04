using Core.Singleton;
using Sigcomt.Business.Entity;
using Sigcomt.Business.Logic.Interfaces;
using Sigcomt.DataAccess;

namespace Sigcomt.Business.Logic
{
    public class ConfiguracionBL : Singleton<ConfiguracionBL>, IConfiguracionBL
    {
        public Configuracion GetConfiguracion(string tipoConfiguracion)
        {
            return ConfiguracionRepository.GetInstance().GetConfiguracion(tipoConfiguracion);
        }
    }
}