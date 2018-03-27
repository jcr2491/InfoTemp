using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface IUbigeoTramo45BL
    {
        List<Zona> GetZonas();
        List<TipoZona> GetTipoZonas();
    }
}