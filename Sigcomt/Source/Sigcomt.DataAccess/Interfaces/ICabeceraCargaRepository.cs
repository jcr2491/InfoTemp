using System;
using System.Collections.Generic;
using Sigcomt.Business.Entity;

namespace Sigcomt.DataAccess.Interfaces
{
    public interface ICabeceraCargaRepository
    {
        CabeceraCarga GetCabeceraCargaProcesado(string tipoArchivo, DateTime fecha);
        List<CabeceraCarga> GetUltimaCargaPorArchivo();
        List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo);
        int Add(CabeceraCarga cabecera);
        bool Update(CabeceraCarga cabecera);
    }
}