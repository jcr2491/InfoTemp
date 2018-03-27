using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class MetaRefinanciadoBL : Singleton<MetaRefinanciadoBL>, IMetaRefinanciadoBL
    {
        public MetaRefinanciado GetMetaRefinanciadoPorMes(string fechaMeta)
        {
            return MetaRefinanciadoRepository.GetInstance().GetMetaRefinanciadoPorMes(fechaMeta);
        }

        public void UpdateFactorCrecimiento(string fechaMeta, double factorCrecimiento)
        {
            MetaRefinanciadoRepository.GetInstance().UpdateFactorCrecimiento(fechaMeta, factorCrecimiento);
        }
    }
}