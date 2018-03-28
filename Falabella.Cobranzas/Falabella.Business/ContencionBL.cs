using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.CrossCutting.Filters;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class ContencionBL : Singleton<ContencionBL>, IContencionBL
    {
        public List<ContencionReport> GetContencion(ContencionFilter filter)
        {
            return ContencionRepository.GetInstance().GetContencion(filter);
        }

        public List<ContencionCierreReport> GetContencionCierre(string fecha)
        {
            return ContencionRepository.GetInstance().GetContencionCierre(fecha);
        }

        public List<RangoContencionCierre> GetRangoContencionCierre(string fecha)
        {
            return ContencionRepository.GetInstance().GetRangoContencionCierre(fecha);
        }

        public List<HistoricoContencionCierre> GetHistoricoContencionCierre(string fecha)
        {
            return ContencionRepository.GetInstance().GetHistoricoContencionCierre(fecha);
        }

        public void AddHistoricoContencionCierre(string fecha)
        {
            ContencionRepository.GetInstance().AddHistoricoContencionCierre(fecha);
        }

        public bool ExisteHistoricoContencionCierre(string fecha)
        {
            return ContencionRepository.GetInstance().ExisteHistoricoContencionCierre(fecha);
        }

        public void DeleteRangos(string fecha)
        {
            ContencionRepository.GetInstance().DeleteRangos(fecha);
        }
    }
}