using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.CrossCutting.Filters;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class ReportBL : Singleton<ReportBL>, IReportBL
    {
        public List<CarteraCastigadaReport> GetCarteraCastigada(CarteraCastigadaFilter filter)
        {
            return ReportRepository.GetInstance().GetCarteraCastigada(filter);
        }

        public List<RecuperoCastigoReport> GetRecuperoCastigo(CarteraCastigadaFilter filter)
        {
            return ReportRepository.GetInstance().GetRecuperoCastigo(filter);
        }

        public List<CarteraRefinanciadaReport> GetCarteraRefinanciada(CarteraRefinanciadaFilter filter)
        {
            return ReportRepository.GetInstance().GetCarteraRefinanciada(filter);
        }

        public List<ProductividadTramo1Report> GetProductividadTramo1(ProductividadFilter filter)
        {
            return ReportRepository.GetInstance().GetProductividadTramo1(filter);
        }

        public List<ProductividadTramo2Report> GetProductividadTramo2(ProductividadFilter filter)
        {
            return ReportRepository.GetInstance().GetProductividadTramo2(filter);
        }

        public List<ProductividadTramo3Report> GetProductividadTramo3(ProductividadFilter filter)
        {
            return ReportRepository.GetInstance().GetProductividadTramo3(filter);
        }

        public List<ProductividadTramo4Report> GetProductividadTramo4(ProductividadFilter filter)
        {
            return ReportRepository.GetInstance().GetProductividadTramo4(filter);
        }

        public List<ProductividadTramo5Report> GetProductividadTramo5(ProductividadFilter filter)
        {
            return ReportRepository.GetInstance().GetProductividadTramo5(filter);
        }
    }
}