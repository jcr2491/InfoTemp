using System;
using System.Collections.Generic;
using System.Data;
using Falabella.Entity;

namespace Falabella.Business.Interfaces
{
    public interface ICabeceraCargaBL
    {
        CabeceraCarga GetCabeceraCargaProcesado(string tipoArchivo, DateTime fecha);
        List<CabeceraCarga> GetUltimaCargaPorArchivo();
        List<CabeceraCarga> GetHistorialCargaPorArchivo(string tipoArchivo);
        int Add(CabeceraCarga cabecera);
        bool Update(CabeceraCarga cabecera);
        void Add(DataTable dt, string nameTable);
    }
}