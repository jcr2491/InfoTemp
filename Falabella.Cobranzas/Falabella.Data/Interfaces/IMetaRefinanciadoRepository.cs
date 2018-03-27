using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IMetaRefinanciadoRepository
    {
        MetaRefinanciado GetMetaRefinanciadoPorMes(string fechaMeta);
        void UpdateFactorCrecimiento(string fechaMeta, double factorCrecimiento);
    }
}