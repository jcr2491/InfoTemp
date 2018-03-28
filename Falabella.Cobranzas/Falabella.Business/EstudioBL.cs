using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class EstudioBL : Singleton<EstudioBL>, IEstudioBL
    {
        public List<Estudio> GetEstudios(string fechaMeta)
        {
            return EstudioRepository.GetInstance().GetEstudios(fechaMeta);
        }

        public void DeleteEstudioMeta(string fechaMeta)
        {
            EstudioRepository.GetInstance().DeleteEstudioMeta(fechaMeta);
        }

        public List<RegionEstudio> GetRegionEstudios()
        {
            return EstudioRepository.GetInstance().GetRegionEstudios();
        }

        public List<TipoEstudio> GetTipoEstudios()
        {
            return EstudioRepository.GetInstance().GetTipoEstudios();
        }
    }
}