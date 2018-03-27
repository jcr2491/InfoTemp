using System.Collections.Generic;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IContencionRepository
    {
        List<ContencionReport> GetContencion(ContencionFilter filter);
        List<ContencionCierreReport> GetContencionCierre(string fecha);
        List<RangoContencionCierre> GetRangoContencionCierre(string fecha);
        List<HistoricoContencionCierre> GetHistoricoContencionCierre(string fecha);
        void AddHistoricoContencionCierre(string fecha);
        bool ExisteHistoricoContencionCierre(string fecha);
        void DeleteRangos(string fecha);
    }
}