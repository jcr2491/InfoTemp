using System.Collections.Generic;
using Falabella.CrossCutting.Filters;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IReportRepository
    {
        List<CarteraCastigadaReport> GetCarteraCastigada(CarteraCastigadaFilter filter);
        List<ProductividadTramo1Report> GetProductividadTramo1(ProductividadFilter filter);
        List<ProductividadTramo2Report> GetProductividadTramo2(ProductividadFilter filter);
        List<ProductividadTramo3Report> GetProductividadTramo3(ProductividadFilter filter);
        List<ProductividadTramo4Report> GetProductividadTramo4(ProductividadFilter filter);
        List<ProductividadTramo5Report> GetProductividadTramo5(ProductividadFilter filter);
        List<RecuperoCastigoReport> GetRecuperoCastigo(CarteraCastigadaFilter filter);
    }
}