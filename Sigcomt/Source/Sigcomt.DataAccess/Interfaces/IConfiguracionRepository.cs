using Sigcomt.Business.Entity;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface IConfiguracionRepository
    {
        Configuracion GetConfiguracion(string tipoConfiguracion);
    }
}