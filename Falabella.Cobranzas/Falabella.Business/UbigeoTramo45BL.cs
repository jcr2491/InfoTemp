using System.Collections.Generic;
using Core.Singleton;
using Falabella.Business.Interfaces;
using Falabella.Data;
using Falabella.Entity;

namespace Falabella.Business
{
    public class UbigeoTramo45BL : Singleton<UbigeoTramo45BL>, IUbigeoTramo45BL
    {
        public List<Zona> GetZonas()
        {
            return UbigeoTramo45Repository.GetInstance().GetZonas();
        }

        public List<TipoZona> GetTipoZonas()
        {
            return UbigeoTramo45Repository.GetInstance().GetTipoZonas();
        }
    }
}