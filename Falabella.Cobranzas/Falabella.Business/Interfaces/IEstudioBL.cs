using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IEstudioBL
    {
        List<Estudio> GetEstudios(string fechaMeta);
        void DeleteEstudioMeta(string fechaMeta);
        List<RegionEstudio> GetRegionEstudios();
        List<TipoEstudio> GetTipoEstudios();
    }
}