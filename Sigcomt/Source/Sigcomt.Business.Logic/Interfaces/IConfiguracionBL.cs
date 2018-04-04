using Sigcomt.Business.Entity;

namespace Sigcomt.Business.Logic.Interfaces
{
    public interface IConfiguracionBL
    {
        Configuracion GetConfiguracion(string tipoConfiguracion);
    }
}