using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IEstudioRepository
    {
        List<Estudio> GetEstudios(string fechaMeta);
        void DeleteEstudioMeta(string fechaMeta);
        List<RegionEstudio> GetRegionEstudios();
        List<TipoEstudio> GetTipoEstudios();
    }
}