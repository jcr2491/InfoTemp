using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IMetaRefinanciadoBL
    {
        MetaRefinanciado GetMetaRefinanciadoPorMes(string fechaMeta);
        void UpdateFactorCrecimiento(string fechaMeta, double factorCrecimiento);
    }
}