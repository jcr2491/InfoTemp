using System.Collections.Generic;
using Falabella.Entity;

namespace Falabella.Data.Interfaces
{
    public interface IUbigeoTramo45Repository
    {
        List<Zona> GetZonas();
        List<TipoZona> GetTipoZonas();
    }
}